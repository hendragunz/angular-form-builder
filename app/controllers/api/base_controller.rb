class Api::BaseController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_filter :restrict_access
  #after_filter :cors_set_access_control_headers

  # TODO: add pagination & offset

  # def xss_options_request
  #   render :text => ""
  # end

  private

    def restrict_access
      if request.method != "OPTIONS"
        authenticate_or_request_with_http_token do |token, options|
          api_key = User.exists?(access_token: token)
          @current_user = User.where(access_token: token).first if api_key
        end
      end
    end

    # Return CORS access control headers for all responses.
    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-CSRF-Token'
    end
end