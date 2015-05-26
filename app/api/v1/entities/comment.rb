module V1
  module Entities
  	module Comment

	    class Comments < Grape::Entity
	    	root 'comments'
	      expose :id, :content
	      expose :user, using: V1::Entities::User::UserWithoutToken
	    end
	    
		end
  end
end
