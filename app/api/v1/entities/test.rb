module APIv2
  module Entities
    class Test < Grape::Entity
      expose :name
      expose :accounts, using: ::APIv2::Entities::Account
    end
  end
end
