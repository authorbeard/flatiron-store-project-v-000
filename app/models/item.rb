class Item < ActiveRecord::Base
  has_many :line_items
  has_many :carts, through: :line_items
  belongs_to :category

  before_create :set_default_inventory


  def self.available_items
    where("inventory > 0")
  end

  def set_default_inventory
    self.inventory ||= 0
  end

end
