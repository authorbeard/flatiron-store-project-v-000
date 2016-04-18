class LineItemsController < ApplicationController

  def create
    set_cart
    @cart.add_item(params[:item_id])
    redirect_to cart_path(@cart)
  end



end
