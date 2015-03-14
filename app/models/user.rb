class User < ActiveRecord::Base
  include SendEmail

  has_secure_password

  # 验证
  validates :name, presence: true, length: { in: 3..20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }, on: :create

  # 商品
  has_many :products, dependent: :destroy
  # 收藏
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

  # 代理
  delegate :public_name, :number, :qr_code, :keyword, to: :wechat_info, allow_nil: true
  delegate :gender, :resume, :website, to: :info, allow_nil: true

  # 回调


  # 邮箱验证
  def send_verify_email
    verify_email_token = generate_simple_token(:verify_token)
    save!
    User.send_mail(self.email, "邮箱验证", User.verify_email_template(self.name, verify_email_token))
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

  class << self

    # 密码加密
    def new_remember_token
      SecureRandom.urlsafe_base64
    end
    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def admins
      Figaro.env.admin.split(',')
    end
  end

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
