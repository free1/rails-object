module V1
  module Entities
  	module Article

	    class Articles < Grape::Entity
	    	root 'articles'
	      expose :id, :title, :content, :cover_path, :status
	      expose :user, using: V1::Entities::User::UserDetails
	    end

	    class ArticleDetails < Grape::Entity
	    	root 'article'
	    	expose :id, :title, :content, :status
	    	expose :is_collect do |article, options|
	    		if options[:user]
	    			options[:user].likeing?(article.id, 'Article')
	    		else
	    			false
	    		end
	    	end
	    	expose :user, using: V1::Entities::User::Users
	    end

	    class ArticleLists < Grape::Entity
	    	root 'lists'
	    	expose :id, :content
        with_options(format_with: :iso_timestamp) do
          expose :created_at
        end
	    end

	    class ArticleListDetails < Grape::Entity
	    	expose :id, :content, :translate, :remark_on
	    	with_options(format_with: :iso_timestamp) do
	    		expose :created_at
	    	end
	    end
	    
		end
  end
end
