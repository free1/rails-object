# == Schema Information
#
# Table name: all_github_infos
#
#  id                  :integer          not null, primary key
#  organization_name   :string(255)
#  organization_member :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

# require 'octokit'

class AllGithubInfo < ActiveRecord::Base
  serialize :organization_member, Array

  class << self

    def get_info
      Octokit.auto_paginate = true

      Octokit.configure do |c|
        c.login = 'name'
        c.password = 'pwd'
      end

      Octokit.all_organizations.each do |organization|
        AllGithubInfo.create(organization_name: organization["login"])
      end

      AllGithubInfo.find_each(start: 5370, batch_size: 200) do |all_github_info|
        all_members_name = []
        Octokit.organization_members(all_github_info.organization_name).each do |organization_member|
          all_members_name << organization_member["login"]
          all_github_info.update(organization_member: all_members_name)
        end
      end
    end

    def follow_user
      AllGithubInfo.find_each(start: 2757, batch_size: 200) do |all_github_info|
        p "------------AllGithubInfoID:  #{all_github_info.id}--------------------"
        client = Octokit::Client.new(:login => 'name', :password => 'pwd')
        all_github_info.organization_member.each do |member_name|
          if client.follow(member_name)
            p "follow #{member_name} success"
          else
            p "follow #{member_name} fail"
          end
        end
      end
    end

    def select_member_on_organization
      AllGithubInfo.find_each(start: 2758, batch_size: 200) do |all_github_info|
        if all_github_info.organization_member.include?("theneva")
          p all_github_info.id
        end
      end
    end

    # follow所有用户 AllGithubInfo.following_all_user
    def following_all_user
      begin
        since = FollowingUser.not_since.first.id - 1
        FollowingUser.find_each(start: since, batch_size: 200) do |all_github_info|
          p "------------AllGithubInfoID:  #{all_github_info.id}--------------------"
          client = Octokit::Client.new(:login => ENV['github_name'], :password => ENV['github_password'])
          if client.follow(all_github_info.name)
            all_github_info.update_column(:is_following, true)
            p "follow #{all_github_info.name} success"
          else
            p "follow #{all_github_info.name} fail"
          end
          all_github_info.update_column(:is_since, true)
          # sleep 0.6
        end
      ensure
        AllGithubInfo.following_all_user
      end
    end

    # AllGithubInfo.unfollow_free1_users
    def unfollow_free1_users
      begin
        since = FollowingUser.not_since.first.id - 1
        FollowingUser.find_each(start: since, batch_size: 200) do |all_github_info|
          p "------------AllGithubInfoID:  #{all_github_info.id}--------------------"
          client = Octokit::Client.new(:login => ENV['github_name'], :password => ENV['github_password'])
          if client.unfollow(all_github_info.name)
            all_github_info.update_column(:is_following, false)
            p "unfollow #{all_github_info.name} success"
          else
            p "unfollow #{all_github_info.name} fail"
          end
          all_github_info.update_column(:is_since, true)
        end
      ensure
        AllGithubInfo.unfollow_free1_users
      end
    end

  end

end
