class User < ActiveRecord::Base
  include SendEmail

  has_secure_password

  # 验证
  validates :name, presence: true, length: { in: 3..20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }, on: :create

  # 关联
  has_many :products, dependent: :destroy

  # 邮箱验证
  def send_verify_email
    verify_email_token = generate_simple_token(:verify_token)
    save!
    User.send_mail(self.email, "邮箱验证", User.verify_email_template(self.name, verify_email_token))
  end

  class << self

    # 密码加密
    def new_remember_token
      SecureRandom.urlsafe_base64
    end
    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
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
