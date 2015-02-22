class SettingsController < ApplicationController
	before_action :signed_in_user

	def account
		@user = current_user
	end
	
end