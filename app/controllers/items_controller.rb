class ItemsController < ApplicationController
  before_action :redirect_to_signin, only: [ :new, :create ]

  def index
    
  end

  def show
    
  end

  def sell
    @item = Item.new
    @item_image = @item.images.build
  end

  def new
    @item = Item.new
    @item_image = @item.images.build
  end

  def create
    @item = Item.new(item_params)
  binding.pry
    if @item.valid? && @item_image.present? && @item_image.length <= 10
      @item.save
      params[:images]['image_url'].each do |a|
        @item_image = @item.images.create!(image_url: a)
      end
      redirect_to root_path
    else
      errors_about_images
      redirect_to new_item_path, flash: { error: @item.errors.full_messages }
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
