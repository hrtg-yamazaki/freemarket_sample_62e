class UsersController < ApplicationController

  def mypage
    unless user_signed_in?
      redirect_to signup_path
    end
  end


  def login
    @user = User.new
  end

  

end


