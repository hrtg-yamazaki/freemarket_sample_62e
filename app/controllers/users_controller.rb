class UsersController < ApplicationController

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

  def card_tp
    card = Card.where(user_id: current_user.id).first
    if card.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.pay_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:profile, :nickname)
  end

end

