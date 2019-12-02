class ItemsController < ApplicationController
  before_action :redirect_to_signin, only: [ :new, :create ]

  def index
    @items = Item.limit(10).order('id ASC')
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images
    @seller_items = Item.where(seller_id: @item.seller.id).where.not(id: params[:id]).order('id DESC').limit(6).includes(:images)
  end

  def sell
    @item = Item.new
    @item_image = @item.images.build
  end

  def create
    @item = Item.new(item_params)

    if params[:images].present?
      params[:images]['image_url'].each do |a|
        @item_image = @item.images.new(image_url: a)
      end  
    else
      flash[:image_error] = '画像がありません' 
      @item.valid?
      flash[:error] = @item.errors.full_messages
      redirect_to items_sell_path
      return false
    end


    if @item.valid? && @item.images.length <= 10
      @item.save
      @item_image.save
      redirect_to root_path
    else
      flash[:image_error] = 'アップロードできる画像は10枚までです' if @item.images.length > 10
      flash[:error] = @item.errors.full_messages
      redirect_to items_sell_path
    end

  end


  def buy
    @item = Item.find(params[:id])
    @image = @item.images.first
    @address = current_user.address if current_user.address.present?

    if current_user.card.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(current_user.card.pay_id)
      @default_card_information = customer.cards.retrieve(current_user.card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end


private
  def item_params
    params.require(:item).permit(
      :name, :text, :condition, :price, :size,
      :defrayer, :span, :status, :fav, :prefecture_id, 
      images_attributes: [:image_url]
    ).merge(seller_id: current_user.id)
  end

  def redirect_to_signin
    redirect_to new_user_session_path unless user_signed_in?
  end

  
end
