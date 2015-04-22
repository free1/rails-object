class HomeController < ApplicationController

  def index
  	unless signed_in?
  		render 'cover_home', layout: false
  	end
  end
end
