class Api::V1::SessionsController < Devise::SessionsController

  before_action :signin_params, only: :create
  before_action :load_user, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy

  def create
    if @user.valid_password?(signin_params[:password])
      sign_in "user", @user
      json_response "Signed In successfully", true, {user: @user}, :ok
    else
      json_response "Unauthorized", false, {}, :unauthorized
    end
  end

  def destroy
    sign_out @user
    @user.generate_new_authentication_token
    json_response "Logged out successfully", true, {}, :ok
  end

  private
  def signin_params
    params.require(:sign_in).permit(:email, :password)
  end

  def load_user
    @user = User.find_for_database_authentication(email: signin_params[:email])
    if @user
      return @user
    else
        json_response "User not found", false, {}, :failure
    end
  end

  def valid_token
    @user = User.find_by authentication_token: request.headers["AUTH-TOKEN"]
    if @user
      return @user
    else 
      json_response "Invalid token", false, {}, :failure
    end
  end
end
