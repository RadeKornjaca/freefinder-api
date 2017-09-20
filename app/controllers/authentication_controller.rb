class AuthenticationController < ApplicationController
  before_action :authenticate

  attr_reader :current_user
  
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        @current_user = User.includes(:api_keys)
                            .where(api_keys: { access_token: token })
                            .first if ApiKey.exists?(access_token: token)
      end
    end
    
end
