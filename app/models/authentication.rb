# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
