module V1
  module Entities
    class Posts < Grape::Entity
      expose :title, :content, :created_at
    end
  end
end
