class SignupController < ApplicationController
  before_action :redirect_to_signup, only: [:confirmation, :confirmation_sms, :address, :card, :complete]

  ## 新規会員登録 ##
  def signup
    reset_session
  end

  ## 本人情報入力 ##
  def registration
    @user = User.new
  end

  def registration_post

    session[:nickname]                 = user_params[:nickname]
    session[:email]                    = user_params[:email]
    session[:password]                 = user_params[:password]
    session[:last_name]                = user_params[:last_name]
    session[:first_name]               = user_params[:first_name]
    session[:kana_last_name]           = user_params[:kana_last_name]
    session[:kana_first_name]          = user_params[:kana_first_name]
    session[:birthday]                 = convert_params_into_date
    
    @user = User.new(
      nickname: session[:nickname], email: session[:email], password: session[:password],
      last_name: session[:last_name], first_name: session[:first_name],
      kana_last_name: session[:kana_last_name], kana_first_name: session[:kana_first_name],
      birthday: session[:birthday]
    )

    if @user.valid?
      redirect_to signup_confirm_path
    else
      render :registration
    end

  end

  ## SMS認証(実装は電話番号の登録のみ) ##
  def confirmation
    @user = User.new
  end

  def confirmation_post
    session[:tel_auth]                 = user_params[:tel_auth]
    @user = User.new(email: session[:email], password: session[:password], tel_auth: session[:tel_auth])
    if @user.valid?
      redirect_to signup_confirm_sms_path
    else
      render :confirmation
    end
    
  end
  
  def confirmation_sms
    
  end

  ## Userテーブルの生成 ##
  def user_create

    @user = User.new(

      nickname:              session[:nickname],
      email:                 session[:email],
      password:              session[:password],
      password_confirmation: session[:password],
      last_name:             session[:last_name],
      first_name:            session[:first_name],
      kana_last_name:        session[:kana_last_name],
      kana_first_name:       session[:kana_first_name],
      birthday:              session[:birthday],
      tel_auth:              session[:tel_auth]

    )
    
    if @user.save
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?
      redirect_to signup_address_path
    else
      redirect_to signup_path
    end

  end

  ## 発/配送元 住所入力 ##
  def address
    @address = Address.new
  end
  
  ## 住所テーブルの生成 ##
  def address_create

    @address = Address.new(address_params)
    if @address.valid?
      if @address.save
        redirect_to signup_card_path
      else
        render :address
      end
    else
      render :address
    end
    
  end

  ## 支払い方法(後ほど別ブランチにてpayjpで実装) ##
  def card
    @card = Card.new
  end

  def card_post
    @card = Card.new
    redirect_to signup_complete_path
  end


  def complete
    
  end




  private

  def user_params
    params.require(:user).permit(
      :nickname,  :email,        :password,
      :last_name, :first_name,   :kana_last_name, :kana_first_name,
      :birthday,  :tel_auth,
      :birthday["birthday(1i)"], :birthday["birthday(2i)"],:birthday["birthday(3i)"]
    )
  end

  def address_params
    params.require(:address).permit(
      :last_name,   :first_name, :kana_last_name, :kana_first_name,
      :postal_code, :prefecture, :city,           :block,
      :building,    :tel
    ).merge(user_id: current_user.id)
  end

  def convert_params_into_date
    year  = params[:birthday]["birthday(1i)"].to_i
    month = params[:birthday]["birthday(2i)"].to_i
    day   = params[:birthday]["birthday(3i)"].to_i
    
    if year != 0 || month != 0 || day != 0
      return Date.new(year, month, day)
    end
  end

  def redirect_to_signup
    redirect_to signup_path if session[:email].nil?
  end

end

