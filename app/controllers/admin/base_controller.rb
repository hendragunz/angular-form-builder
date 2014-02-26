class Admin::BaseController < BaseController
  before_filter :verify_admin

  private

    def verify_admin
      redirect_back_or_to forms_url unless current_user && current_account.is_owner?(current_user)
    end

end