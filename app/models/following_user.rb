# == Schema Information
#
# Table name: following_users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  github_user_id :integer
#  avatar_url     :string(255)
#  is_following   :boolean          default(FALSE)
#  is_since       :boolean          default(FALSE)
#

# github all user
class FollowingUser < ActiveRecord::Base
  UsersApi = 'https://api.github.com/users'.freeze
  AccessToken = 'xxx'.freeze
  PerPage = 5000
  TaskTime = 10000

  validates_uniqueness_of :name
  scope :not_since, -> { where(is_since: false) }

  def self.get_all_user
    last_user = FollowingUser.last
    since =  last_user.nil? ? 0 : last_user.github_user_id - 1

    params = {
      since: since,
      per_page: PerPage,
      access_token: AccessToken
    }
    uri = URI.parse(UsersApi)
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    body = res.body
    data = JSON.parse(body)

    data.each do |user|
      p "----------------since: #{since}, user_id: #{user["id"]}, user_name: #{user["login"]}-----------------------"
      user = FollowingUser.new(name: user["login"], github_user_id: user["id"], avatar_url: user["avatar_url"])
      if user.save
        p "----------------create #{user["login"]} success-----------------------"
      else
        p "----------------create #{user["login"]} fail-----------------------"
      end
    end
  end

  # 抓取所有用户: FollowingUser.execute_task
  def self.execute_task
    begin
      FollowingUser.get_all_user
      sleep 0.3
    ensure
      FollowingUser.get_all_user
    end
  end

end
