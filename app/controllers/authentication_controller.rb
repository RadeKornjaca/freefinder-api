class AuthenticationController < ApplicationController
  before_action :authenticate

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(:access_token => token)
      end
    end
    
end
