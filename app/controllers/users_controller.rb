class UsersController < ApplicationController

  layout 'mypage'

  def mypage
    unless user_signed_in?
      redirect_to signup_path
    end
  end

  def profile
    @user = current_user
  end

  def profile_update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :profile
    end
  end

  def logout

  end

  def identification

  end
  
  private

  def user_params
    params.require(:user).permit(:profile, :nickname)
  end

end

