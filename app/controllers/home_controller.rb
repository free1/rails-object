class HomeController < ApplicationController

  def index
    unless signed_in?
        # render 'cover_home', layout: false
        render 'cover_home_v2', layout: false
    end
  end
end
