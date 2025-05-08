class AccountController < ApplicationController
  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    
    if @user.update(user_params)
      redirect_to account_edit_path, notice: "Your email address has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:recovery_email)
    end
end
