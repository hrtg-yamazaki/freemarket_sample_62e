class UsersController < ApplicationController

  layout 'mypage'

  def mypage
    unless user_signed_in?
      redirect_to signup_path
    end
  end

  def profile
    
  end  

  def logout

  end

  def identification

  end

end

