class SignupController < ApplicationController

  def signup
    @user = User.new
  end

  def registration
    @user = User.new
  end

  def registration_post
    session[:nickname]                = user_params[:nickname]
    session[:email]                   = user_params[:email]
    session[:password]                = user_params[:password]
    session[:last_name]               = user_params[:last_name]
    session[:first_name]              = user_params[:first_name]
    session[:kana_last_name]          = user_params[:kana_last_name]
    session[:kana_first_name]         = user_params[:kana_first_name]
    session[:birthday]                = user_params[:birthday]
    redirect_to signup_confirm_path
  end

  def confirmation
    @user = User.new
  end

  def confirmation_post
    session[:tel_auth]                = user_params[:tel_auth]
    redirect_to signup_confirm_sms_path
  end

  def confirmation_sms
    @user = User.new
  end

  def address
    @user = User.new
    @address = Address.new
  end

  def address_post
    session[:last_name]               = address_params[:last_name]
    session[:first_name]              = address_params[:first_name]
    session[:kana_last_name]          = address_params[:kana_last_name]
    session[:kana_first_name]         = address_params[:kana_first_name]
    session[:postal_code]             = address_params[:postal_code]
    session[:prefecture]              = address_params[:prefecture]
    session[:city]                    = address_params[:city]
    session[:block]                   = address_params[:block]
    session[:building]                = address_params[:building]
    session[:tel]                     = address_params[:tel]
    redirect_to signup_card_path
  end

  def card
    @user = User.new
    @card = Card.new
  end


  def complete
  end


  private
  def user_params
    params.require(:user).permit(
      :nickname,   :email,      :password,
      :last_name,  :first_name, :kana_last_name, :kana_first_name,
      :birthday,   :tel_auth,
    )
  end

  def address_params
    params.require(:address).permit(
      :last_name,   :first_name, :kana_last_name, :kana_first_name,
      :postal_code, :prefecture, :city,           :block,
      :building,    :tel
    ).merge(user_id: params[:id])
  end


end


# fields_forを使う場合はこちらでparamsを記述
# address_attributes: [
#   :last_name,   :first_name, :kana_last_name, :kana_first_name,
#   :postal_code, :prefecture, :city,           :block,
#   :building,    :tel
# ]