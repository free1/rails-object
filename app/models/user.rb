# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  remember_token         :string(255)
#  verify_token           :string(255)
#  is_verify_email        :boolean          default(FALSE)
#  avatar_path            :string(255)
#  is_email_push          :boolean          default(TRUE)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  phone                  :string(255)
#

# encoding=utf-8
class User < ActiveRecord::Base
  include SendEmail
  include ThirdParty
  include Searchable

  has_secure_password
  # obfuscate_id

  # invisible_captcha验证码
  attr_accessor :subtitle # define a virtual attribute, the honeypot
  validates :subtitle, :invisible_captcha => true
  # 验证
  validates :name, presence: true, length: { in: 3..20 }, uniqueness: true, :exclusion => { :in => %w(admin) }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    :allow_blank => true,
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }, on: :create
  validates_uniqueness_of   :phone, :allow_nil => true
  validates_format_of       :phone,    :with => /\A1\d{10}\z/, :allow_blank => true

  # save之前
  before_save { |user| user.email = email.downcase }
  before_save { |user| user.name = name.downcase }

  # 第三方账户
  has_many :authentications, dependent: :destroy
  # 商品
  has_many :products, dependent: :destroy
  # 商品收藏
  has_many :user_collect_products, dependent: :destroy
  has_many :collect_products, through: :user_collect_products, source: :product
  # 用户详细信息
  has_one :info, dependent: :destroy, class_name: 'UserInfo'
  accepts_nested_attributes_for :info
  has_one :wechat_info, dependent: :destroy
  accepts_nested_attributes_for :wechat_info
  # 粉丝
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  # 所属tag标签
  has_many :user_tag_ships, dependent: :destroy
  has_many :tags, through: :user_tag_ships
  # 评论
  has_many :comments, dependent: :destroy
  # 抓取硬件文章
  has_many :posts, dependent: :destroy
  # 消息通知(系统，用户)
  has_many :notifications, foreign_key: 'receiver_id', dependent: :destroy

  # 日知文章
  has_many :articles, dependent: :destroy
  # 日知讲座
  has_many :chairs, dependent: :destroy
  # 日知栏目关注(使用多态)
  has_many :user_collects, dependent: :destroy
  has_many :collect_articles, through: :user_collects, source: :listable, source_type: "Article"
  # 日知讲座关注(使用多态)
  has_many :collect_chairs, through: :user_collects, source: :listable, source_type: "Chair"


  # 代理
  delegate :public_name, :number, :qr_code, :keyword, to: :wechat_info, allow_nil: true
  delegate :gender, :resume, :website, :longitude, :latitude, to: :info, allow_nil: true

  # 搜索距离位置(sunspot)
  # searchable do
  #   latlon(:location) { Sunspot::Util::Coordinates.new(latitude, longitude) }
  # end
  # 搜索es
  def as_indexed_json(options={})
    hash = self.as_json(
      except: [:password_digest, :remember_token, :verify_token],
      include: {
        info: {
          only: [:id, :gender, :resume, :website, :longitude, :latitude]
        }
      }).merge location: { lon: self.longitude, lat: self.latitude }
    hash
  end
  settings index: { number_of_shards: 1, number_of_replicas: 0 }  do
    mapping do
      indexes :name,      analyzer: 'snowball'
      indexes :id
      indexes :email
      indexes :location, type: 'geo_point'
    end
  end

  # 每次登录注册记录所在位置
  def update_location(latitude, longitude)
    self.info.update(latitude: latitude, longitude: longitude)
  end

  # 快捷查找
  def all_feeds
    PublicActivity::Activity.where(recipient_type: ["Post", "Product"], owner_id: self.followed_users.map(&:id))
  end

  # 邮箱验证
  def send_verify_email
    verify_email_token = generate_simple_token(:verify_token)
    save!
    User.send_mail(self.email, "邮箱验证", User.verify_email_template(self.name, verify_email_token))
  end

  # 发送密码找回邮件
  def send_password_reset
    password_reset_token = generate_simple_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    # todo 发送邮件
    User.delay.send_mail_with_template(self.email, "35122_invoke_1",  { "%code%" => [password_reset_token]})
    # UserMailer.password_reset(self).deliver
  end

  # 关注
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  # 收藏
  def collecting?(collect_id, collect_type)
    type = ActiveSupport::Inflector.pluralize(collect_type)
    self.send("user_collect_#{type}").find_by("#{collect_type}_id" => collect_id)
  end
  def collect!(collect_id, collect_type)
    type = ActiveSupport::Inflector.pluralize(collect_type)
    self.send("user_collect_#{type}").create!("#{collect_type}_id" => collect_id)
  end
  def cancel_collect!(collect_id, collect_type)
    type = ActiveSupport::Inflector.pluralize(collect_type)
    self.send("user_collect_#{type}").find_by("#{collect_type}_id" => collect_id).destroy
  end

  # 优化后关注(收藏)
  def likeing?(listable_id, listable_type, kind)
    is_like = user_collects.find_by(listable_id: listable_id, listable_type: listable_type, kind: kind)
    if is_like
      true
    else
      false
    end
  end
  def like!(listable_id, listable_type, kind)
    user_collects.create!(listable_id: listable_id, listable_type: listable_type, kind: kind)
  end
  def cancel_like!(listable_id, listable_type, kind)
    user_collects.find_by(listable_id: listable_id, listable_type: listable_type, kind: kind).destroy
  end

  # 标签
  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end
  def tag_tokens
    self.tags
  end

  # 权限
  def admin?
    @is_admin ||= self.class.admins.include?(self.email)
  end

  # 存储第三方信息
  def add_auth(auth_hash, user_id)
    authentications.build_auth(auth_hash, user_id).save
  end

  class << self

    # 密码加密
    def new_remember_token
      SecureRandom.urlsafe_base64
    end
    # 加密
    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
    # 第三方登录
    def from_auth(auth_hash)
      locate_auth(auth_hash) || create_from_auth(auth_hash)
    end
    # 固定admin
    def admins
      Figaro.env.admin.split(',')
    end

    # 类私有方法
    private
      def locate_auth(auth_hash)
        Authentication.locate(auth_hash).try(:user)
      end
      def create_from_auth(auth_hash)
        password = User.new_remember_token
        begin
          avatar_path = auth_hash['info']['image'] || auth_hash['info']['headimgurl']
          User.transaction do
            user = create(email: auth_hash['info']['email'], name: auth_hash['info']['nickname'],
                          avatar_path: avatar_path, password: password)
            user.add_auth(auth_hash, user.id)
            # user.send :create_remember_token
            user
          end
        rescue Exception => ex
          puts "-------创建失败--------"
          puts "-------#{ex.message}--------"
        end
      end
  end

  # 实例私有方法
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    # 简单加密
    def generate_simple_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
      self[column]
    end

end
