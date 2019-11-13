class SignupController < ApplicationController

  def signup
  end

  def registration
    @user = User.new
  end

  def confirmation
    @user = User.new
  end

  def confirmation_sms
  end

  def address
    @user = User.new
  end

  def card
    @user = User.new
  end

  def complete
  end

end
