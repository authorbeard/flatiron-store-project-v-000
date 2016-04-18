class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_user
    @user=current_user
  end

  def after_sign_in_path_for(user)
    set_cart
    user_path(current_user)
  end

  def set_cart
    @cart ||= current_user.current_cart
    if @cart.nil?
      @cart=current_user.carts.build
    end
  end


end
