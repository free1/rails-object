module Member
	class NotificationsController < ApplicationController
		before_action :signed_in_user
		after_action :mark_read, only: :index

		def index
			@notifications = current_user.notifications.not_deleted.recent
		end

	  def destroy
	    @notification = current_user.notifications.find(params[:id])
	    if @notification.update(status: Notification.statuses["deleted"])
		    respond_to do |format|
		    	format.js
		    end
		  end
	  end

		private
			def mark_read
				current_user.notifications.update_all(status: Notification.statuses["readed"])
			end
	end
end