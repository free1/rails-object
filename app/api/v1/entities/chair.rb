module V1
  module Entities
  	module Chair

	    class Chairs < Grape::Entity
	    	root 'chairs'
	      expose :id, :title, :content
	      with_options(format_with: :iso_timestamp) do
	      	expose :created_at
	      end
	    end

	    class ChairDetail < Grape::Entity
	    end
	    
		end
  end
end
