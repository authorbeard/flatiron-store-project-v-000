class User < ActiveRecord::Base
  attr_writer :current_cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :line_items, through: :carts


  def current_cart
    self.carts.detect{|c| c.status == "current"}
  end


  private
    def self.seed_helper
      all.each do |u|
        c = Cart.create
        c.line_items.build(item_id: u.id, quantity: (11-u.id))
        u.carts << c
        u.save
      end 
    end
  
end


