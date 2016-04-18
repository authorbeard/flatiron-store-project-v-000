class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  before_create :set_default


  def set_default
    self.quantity||=1
  end

  def subtotal
    item.price * quantity
  end
end
