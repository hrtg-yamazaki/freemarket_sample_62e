class ItemsController < ApplicationController

  before_action :redirect_to_signin, only: [ :sell, :create, :edit, :update, :destroy, :buy, :buy_post ]
  before_action :set_item, only: [ :show, :edit, :update, :destroy, :buy, :buy_post ]


  def index
    @items = Item.limit(10).order('id DESC')
  end

  def show
    redirect_to onsale_item_path(@item) if @item.seller_id == current_user.id
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
      @item_image.save
      @item.save
      redirect_to root_path
    else
      flash[:image_error] = 'アップロードできる画像は10枚までです' if @item.images.length > 10
      flash[:error] = @item.errors.full_messages
      redirect_to items_sell_path
    end
  end

  def edit
    (10- @images.length).times do
      @add_image = @item.images.build
    end
  end

  def update

    if params[:images].nil? && @images.nil?
      flash[:image_error] = '画像がありません' 
      @item.valid?
      flash[:error] = @item.errors.full_messages
      redirect_to edit_item_path
      return false
    end


    if @item.seller_id == current_user.id  && @item.update(update_item_params) 
      @no_images = Image.where(image_url: "no image" )
      if @no_images.present?
        @no_images.each do |n|
          n.destroy
        end
      end
      redirect_to onsale_item_path

    else
      flash[:error] = @item.errors.full_messages
      redirect_to edit_item_path
    end
  end


  def destroy

    if @item.seller_id == current_user.id && @item.destroy
      redirect_to listings_path
    else
      redirect_to root_path
    end
  end

  def complete

  end

  ## 商品購入機能 ##
  def buy
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

  require "payjp"
  def buy_post
    if current_user.card.blank?
      redirect_to action: "card_update"
    else 
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      Payjp::Charge.create(
        amount: @item.price,
        customer: current_user.card.pay_id,
        currency:'jpy',
      )
      calculate_profit
    end
      if @item.update(status: 1, buyer_id: current_user.id)
        redirect_to action: 'complete'
      else 
        flash[:alert] = '購入に失敗しました'
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

  def update_item_params
    params.require(:item).permit(
      :name, :text, :condition, :price, :size,
      :defrayer, :span, :status, :fav, :prefecture_id, 
      :image_chache,
      images_attributes: [:image_url, :_destroy, :id]
    ).merge(seller_id: current_user.id)
  end

  def redirect_to_signin
    redirect_to login_path unless user_signed_in?
  end

  def calculate_profit
    input = @item.price
    fee = (input / 10).floor
    benefit = input - fee
    if @item.seller.profit.nil?
      @item.seller.update(profit: benefit)
    else
      total_profit = @item.seller.profit += benefit
      @item.seller.update(profit: total_profit)
    end
  end

  def set_item
    @item = Item.find(params[:id])
    @images = @item.images
  end
  
end
