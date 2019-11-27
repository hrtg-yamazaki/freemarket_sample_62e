class ItemsController < ApplicationController

  def index
    
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images
    @seller_items = Item.where(seller_id: @item.seller.id).where.not(id: params[:id]).order('id DESC').limit(6).includes(:images)
  end
  
end
