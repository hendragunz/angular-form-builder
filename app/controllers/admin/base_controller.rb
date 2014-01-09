class Admin::BaseController < ApplicationController
  #before_filter :verify_admin

  private
    
    def verify_admin
      redirect_to login_url unless current_user && current_user.admin?
    end

end