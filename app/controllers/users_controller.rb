class UsersController < ApplicationController

  before_action :set_card, only:[:card, :card_delete]

  def mypage
    unless user_signed_in?
      redirect_to login_path
    end
  end

  def profile
    @user = current_user
  end  

  def logout

  end

  def identification

  end

  ## 登録カード情報表示・編集 ##
  require "payjp"


  def card
    unless @credit_card.blank?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@credit_card.pay_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
    end
  end

  def card_create

  end

  def card_update
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    if params['payjp-token'].blank?
      render :card
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        )
        @card = Card.new(user_id: current_user.id, pay_id: customer.id, card_id: customer.default_card)
        if @card.save
          redirect_to action: "card"
        else
          render :card
        end
      end
  end

  def complete

  end


  def listings
    @items = Item.where(seller_id: current_user.id).order('id DESC').includes(:images).page(params[:page]).per(10)
  end

  def sell_item
    @item = Item.find(params[:id])
    @images = @item.images
  end
  
  private

  def card_delete
    if @credit_card.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@credit_card.pay_id)
      customer.delete
      @credit_card.delete
    end
    redirect_to action: "card"
  end

  private

  def set_card
    @credit_card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end