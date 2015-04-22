class OmniauthsController < ApplicationController

	def create
		user = User.from_auth(request.env['omniauth.auth'])
		sign_in user
		flash.now[:success] = "Welcome #{user.name}"
		redirect_to root_path
	end
end