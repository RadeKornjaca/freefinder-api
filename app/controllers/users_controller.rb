class UsersController < ApplicationController
  before_action :find_by_login_credentials, :only => [:device_sign_in]
  before_action :find_by_access_token, :only => [:device_sign_out]

  # POST /users
  def create
      @user = User.new(user_params)
      @user.api_keys << ApiKey.new

      if @user.save
        render :json => @user.api_keys.first, :status => :created
      else
        render :status => :unprocessable_entity
      end
  end

  # POST /device_sign_in
  def device_sign_in
    if @user.update_attributes(:api_keys => @user.api_keys << ApiKey.new)
      render :json => @user.api_keys.last, :status => :created
    else
      render :json => @user.errors, :status => :unprocessable_entity
    end
  end

  # DELETE /device_sign_out
  def device_sign_out
    @access_token.destroy
  end

  private
    def find_by_login_credentials
      @user = User.find_by_email(params[:email]).authenticate(params[:password])
    end

    def find_by_access_token
      @access_token = ApiKey.find_by_access_token(params[:access_token])
    end

    "def bind_api_key
      api_key = ApiKey.new(:user => @user) if @user    # create a token and bind it to a user
      if api_key.save
        render :json => api_key, :status => :created
      else
        render :status => :unprocessable_entity
      end
    end"

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
