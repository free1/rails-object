module APIv2
  module Entities
    class Test < Base
      expose :name
      expose :accounts, using: ::APIv2::Entities::Account
    end
  end
end
