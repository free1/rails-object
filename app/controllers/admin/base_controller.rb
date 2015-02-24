module Admin
  class BaseController < ::ApplicationController
    layout 'admin'

    before_action :auth_admin!

    # def current_ability
    #   @current_ability ||= Admin::Ability.new(current_user)
    # end
    
  end
end

