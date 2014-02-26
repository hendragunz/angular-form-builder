class BaseController < ApplicationController
	include Authz

  before_filter :require_login
  before_filter :load_account

  helper_method :current_account, :abilities, :can?

  def current_account
    @current_account
  end

  private

    # Permissions as per the six gem
    def abilities
      @abilities ||= Six.new
    end

    def can?(user, action, subject)
      # simple delegate method for controller & view
      abilities.allowed?(user, action, subject)
    end

    def not_authenticated
      redirect_to login_url, alert: "#{t 'please_sign_in'}"
    end

    def load_account
      if current_user && @current_account.nil?
        @current_account = current_user.account
      end
    end
end