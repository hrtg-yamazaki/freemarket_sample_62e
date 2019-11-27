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

  ## 登録カード情報表示・編集 ##
  require "payjp"

  def card
    card = Card.where(user_id: current_user.id).first
    unless card.blank?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.pay_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def card_create

  end

  def card_update
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    if params['payjp-token'].blank?
      redirect_to action: "card"
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        )
        @card = Card.new(user_id: current_user.id, pay_id: customer.id, card_id: customer.default_card)
        if @card.save
          redirect_to action: "card"
        else
          redirect_to action: "card_update"
        end
      end
  end

  def complete

  end

  def card_delete
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else 
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.pay_id)
      customer.delete
      card.delete
    end
    redirect_to action: "card"
  end

end