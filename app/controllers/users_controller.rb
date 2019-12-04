class UsersController < ApplicationController

  before_action :redirect_to_login
  before_action :set_card, only:[:card, :card_delete]

  def mypage
    
  end

  def profile
    @user = current_user
  end  

  def logout

  end

  def identification
    
  end

  ## カード情報表示・削除・再登録・ ##
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

  # def address
  #   if current_user.address.present?
  #     @address = current_user.address
  #   else
  #     @address = Address.new()
  #   end
  # end

  # def address_update
  #   binding.pry
  #   if current_user.address.update(address_params)
  #     binding.pry
  #     redirect_to mypage_address_path
  #   else
  #     render :address
  #   end
  # end

  # def address_create
  #   @address = Address.new(address_params)
  #   if @address.valid?(:address_create)
  #     if @address.save
  #       redirect_to mypage_address_path
  #     else
  #       render :address
  #     end
  #   else
  #     render :address
  #   end
  # end

  def complete

  end

  def listings
    @items = Item.where(seller_id: current_user.id).order('id DESC').includes(:images).page(params[:page]).per(10)
  end

  def sell_item
    @item = Item.find(params[:id])
    @images = @item.images
  end

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

  # def address_params
  #   params.require(:address).permit(
  #     :last_name,   :first_name,    :kana_last_name, :kana_first_name,
  #     :postal_code, :prefecture_id, :city,           :block,
  #     :building,    :tel
  #   ).merge(user_id: current_user.id)
  # end

  def set_card
    @credit_card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

  def redirect_to_login
    redirect_to login_path unless user_signed_in?
  end

end