class LineItemsController < ApplicationController

  def create
# binding.pry
    set_cart
    @cart.add_item(params[:item_id])
# binding.pry
    redirect_to cart_path(@cart)
  end



end
