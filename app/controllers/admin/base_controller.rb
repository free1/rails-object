module Admin
  class BaseController < ::ApplicationController
    layout 'admin'
    before_action :auth_admin!
    
  end
end