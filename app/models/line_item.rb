class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  validates_presence_of :item_id, :cart_id
  before_create :set_default


  def set_default
    self.quantity||=1
  end
end
