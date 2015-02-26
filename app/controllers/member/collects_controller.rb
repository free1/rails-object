module Member
  class CollectsController < ::ApplicationController
		before_action :signed_in_user

		def create
			current_user.collect!(params[:collect_id], params[:collect_type])
			respond_to do |format|
				format.html { redirect_to @user }
				format.js
			end
		end

		def destroy
			current_user.cancel_collect!(params[:id], params[:collect_type])
			respond_to do |format|
				format.html { redirect_to @user }
				format.js
			end
		end

  end
end