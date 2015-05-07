module V1
  module Entities
  	module User
	    class Users < Grape::Entity
	    	root 'users', 'user'
	      expose :id, :name, :email, :avatar_path, :remember_token, :resume
	    end

	    class UserDetails < Grape::Entity
	    	root 'user'
	    	expose :id, :name
	    end
	  end
  end
end
