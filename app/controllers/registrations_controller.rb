class RegistrationsController < AuthenticationController
  allow_unauthenticated_access
  rate_limit to: 5, within: 3.minutes, only: :create, with: -> { redirect_to new_registration_url, alert: "Too many attempts. Try again later." }

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Welcome! Your account has been created."
    else
      redirect_to new_registration_path, alert: user.errors.full_messages.to_sentence
    end
  end

  private
    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
end 