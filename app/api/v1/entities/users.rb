module V1
  module Entities
    class Users < Grape::Entity
    	root 'users', 'user'
      expose :id, :name, :email, :avatar_path, :remember_token
    end
  end
end
