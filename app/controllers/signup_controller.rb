class SignupController < ApplicationController
  

  def signup
    
  end


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
    redirect_to signup_confirm_path
  end


  def confirmation
    @user = User.new
  end

  def confirmation_post
    session[:tel_auth]                 = user_params[:tel_auth]
    redirect_to signup_confirm_sms_path
  end
  
  def confirmation_sms
    
  end


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
      binding.pry
      redirect_to signup_address_path
    else
      reset_session
      redirect_to signup_path
    end

  end


  def address
    @address = Address.new
  end

  def address_create
    binding.pry
    @address = Address.new(address_params)
    if @address.save
      redirect_to signup_card_path
    else
      render :address
    end
  end


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
    return Date.new(params[:birthday]['birthday(1i)'].to_i,
                    params[:birthday]['birthday(2i)'].to_i, 
                    params[:birthday]['birthday(3i)'].to_i)
  end
  

end


# fields_forを使う場合はこちらでparamsを記述
# address_attributes: [
#   :last_name,   :first_name, :kana_last_name, :kana_first_name,
#   :postal_code, :prefecture, :city,           :block,
#   :building,    :tel
# ]


# session[:address_last_name]       = address_params[:last_name]
#     session[:address_first_name]      = address_params[:first_name]
#     session[:address_kana_last_name]  = address_params[:kana_last_name]
#     session[:address_kana_first_name] = address_params[:kana_first_name]
#     session[:postal_code]             = address_params[:postal_code]
#     session[:prefecture]              = address_params[:prefecture]
#     session[:city]                    = address_params[:city]
#     session[:block]                   = address_params[:block]
#     session[:building]                = address_params[:building]
#     session[:tel]                     = address_params[:tel]
    



# params[:user][:birthday].values,join(",")