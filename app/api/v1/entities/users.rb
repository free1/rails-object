module V1
  module Entities
    class Users < Grape::Entity
      expose :name, :email, :avatar_path
    end
  end
end
