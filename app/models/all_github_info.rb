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
      AllGithubInfo.find_each(start: 75, batch_size: 200) do |all_github_info|
        p "------------AllGithubInfoID:  #{all_github_info.id}--------------------"
        client = Octokit::Client.new(:login => 'free1', :password => 'chenlovedota1234')
        all_github_info.organization_member.each do |member_name|
          if client.follow(member_name)
            p "follow #{member_name} success"
          else
            p "follow #{member_name} fail"
          end
        end
      end
    end

  end

end
