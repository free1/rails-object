module Member
	class TagsController < ::ApplicationController
		# before_action :signed_in_user

		def index
			@tags = Tag.all

			respond_to do |format|
				format.html
				format.json { render json: @tags.tokens(params[:q]) }
			end
		end
	end
end