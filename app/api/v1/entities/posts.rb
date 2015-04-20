module V1
  module Entities
    class Posts < Grape::Entity
      expose :title, :content, :created_at
      expose :user, using: V1::Entities::Users
    end
  end
end
