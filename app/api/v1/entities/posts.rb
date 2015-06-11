module V1
  module Entities
    class Posts < Grape::Entity
      expose :id, :title, :cover_path
      # expose :user, using: V1::Entities::User::Users
    end

    class Post < Grape::Entity
    	expose :id, :title, :content, :source_site, :cover_path
    end
  end
end
