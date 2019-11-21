class UsersController < ApplicationController

  layout 'mypage'

  def index  
  end

  def mypage
    unless user_signed_in?
      redirect_to signup_path
    end
  end

end

