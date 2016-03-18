module Admin
  class BaseController < ::ApplicationController
    layout 'admin'
    before_action :auth_admin!
    include Admin::BaseHelper
    
  end
end