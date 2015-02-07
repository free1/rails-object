class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, length: { in: 3..20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }

  class << self

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
