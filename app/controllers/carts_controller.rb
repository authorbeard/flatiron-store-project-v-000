class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
    set_cart
  end

  def new
  end

  def create
  end

  def edit
  end

  def checkout
# binding.pry
    cart=current_user.current_cart
    cart.checkout
    redirect_to cart_path(cart)
  end

  def destroy
  end

  


end
