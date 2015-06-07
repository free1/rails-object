module V1
  module Entities
    class Posts < Grape::Entity
      expose :id, :title, :content, :created_at, :cover_path, :source_site
      # expose :user, using: V1::Entities::User::Users
    end
  end
end
