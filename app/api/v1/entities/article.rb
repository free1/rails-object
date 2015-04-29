module V1
  module Entities
  	module Article

	    class Articles < Grape::Entity
	    	root 'articles'
	      expose :title
	    end

	    class ArticleDetails < Grape::Entity
	    	root 'article'
	    	expose :title, :content, :status
	    	expose :is_collect do |article, options|
	    		if options[:user]
	    			options[:user].likeing?(article.id, 'Article')
	    		else
	    			false
	    		end
	    	end
	    	expose :user, using: V1::Entities::User::Users
	    end
	    
		end
  end
end