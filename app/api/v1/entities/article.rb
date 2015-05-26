module V1
  module Entities
  	module Article

	    class Articles < Grape::Entity
	    	root 'articles'
	      expose :id, :title, :content, :cover_path
	      expose :status do |article|
	      	case article.status
	      	when 'updating'
	      		'更新中'
	      	when 'finished'
	      		'完结'
	      	end
	      end
	      expose :user, using: V1::Entities::User::UserDetails
	    end

	    class ArticleDetails < Grape::Entity
	    	root 'article'
	    	expose :id, :title, :content, :author
	    	expose :status do |article|
	      	case article.status
	      	when 'updating'
	      		'更新中'
	      	when 'finished'
	      		'完结'
	      	end
	      end
	    	expose :is_collect do |article, options|
	    		if options[:user]
	    			options[:user].likeing?(article.id, 'Article', 'favorite')
	    		else
	    			false
	    		end
	    	end
	    	expose :user, using: V1::Entities::User::UserWithoutToken
	    end

	    class ArticleLists < Grape::Entity
	    	root 'lists'
	    	expose :id, :content, :periods
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
