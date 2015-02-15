class User < ActiveRecord::Base
  include SendEmail

  has_secure_password

  # 验证
  validates :name, presence: true, length: { in: 3..20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }

  # 关联
  has_many :products, dependent: :destroy

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

end
