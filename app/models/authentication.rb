class Authentication < ActiveRecord::Base
	belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :user, presence: true

  class << self
    def locate(auth)
      uid      = auth['uid'].to_s
      provider = auth['provider']
      find_by_provider_and_uid provider, uid
    end

    def build_auth(auth, user_id)
      new \
        uid:      auth['uid'],
        provider: auth['provider'],
        user_id:  user_id
        # token:    auth['credentials'].try(:[], 'token'),
        # secret:   auth['credentials'].try(:[], 'secret'),
        # nickname: auth['info'].try(:[], 'nickname')
    end
  end
end
