class User < ActiveRecord::Base
  attr_writer :current_cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :line_items, through: :carts

  ## Prob. delegate items/categories and so on
  ## This must be where orders come in. 


  def current_cart
    self.carts.detect{|c| c.status == "current"}
  end
  
end
