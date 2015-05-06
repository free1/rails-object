module V1
  module Entities
  	module User
	    class Users < Grape::Entity
	    	root 'users', 'user'
	      expose :id, :name, :email, :avatar_path, :remember_token, :resume
	    end
	  end
  end
end
