class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exists, only: :create

  # Signup
  def create
    user = User.new user_params
    if user.save
      json_response "Signed up successfully", true, {user: user}, :ok
    else
      json_response "Something went wrong", false, {}, :unprocessable_intity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exists
    return if params[:user].present?
    json_response "Missing parameters", false, {}, :bad_request
  end
end
