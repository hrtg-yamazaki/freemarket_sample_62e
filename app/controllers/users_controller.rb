class UsersController < ApplicationController

  def mypage
    unless user_signed_in?
      redirect_to signup_path
    end
  end


end


