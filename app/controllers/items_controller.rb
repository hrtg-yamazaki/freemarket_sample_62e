class ItemsController < ApplicationController
  before_action :redirect_to_signin, only: [ :sell, :create, :edit, :update ]
  before_action :set_item, only: [ :show, :edit, :update ]

  def index
    @items = Item.limit(10).order('id DESC')
  end

  def show
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


    if @item.seller_id == current_user.id  && item.update(update_item_params) 
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
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
    @images = @item.images
  end

  
end
