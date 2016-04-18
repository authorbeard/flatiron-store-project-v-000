class StoreController < ApplicationController

  def index
    # set_cart
    @categories=Category.all
    @items=Item.available_items
  end


end
