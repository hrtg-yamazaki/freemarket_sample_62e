class UsersController < ApplicationController

  def mypage
  end
  
  def create
    redirect_to signup_complete_path
  end

end


