module Member
	class NotificationsController < ApplicationController
		before_action :signed_in_user
		after_action :mark_read, only: :index

		def index
			@notifications = current_user.notifications.recent
		end

	  def destroy
	    @notification = current_user.notifications.find(params[:id])
	    @notification.destroy
	    redirect_to notifications_path
	  end

		private
			def mark_read
				current_user.notifications.update_all(status: Notification.statuses["readed"])
			end
	end
end