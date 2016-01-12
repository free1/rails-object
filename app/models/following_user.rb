# == Schema Information
#
# Table name: following_users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  github_user_id :integer
#

# github all user
class FollowingUser < ActiveRecord::Base
  UsersApi = 'https://api.github.com/users'.freeze
  AccessToken = 'ab6483f138fc31feea38d46cc8f78f260085ce4f'.freeze
  PerPage = 1000
  TaskTime = 5000

  validates_uniqueness_of :name

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

  def self.execute_task
    TaskTime.times do |i|
      FollowingUser.get_all_user
      p  "---------------time: #{i}-----------------------"
      sleep 0.6
    end
  end

end
