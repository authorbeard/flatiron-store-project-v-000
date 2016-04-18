class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  enum status: [:current, :submitted]
  before_create :set_default_status

  def set_default_status
    self.status="current"
  end

  def total
    line_items.collect{|l| l.subtotal}.reduce(:+)
  end 

  def add_item(item_id, new_quantity=1)
    if line_items.find_by(item_id: item_id) 
      item_add=line_items.find_by(item_id: item_id)
      item_add.quantity+=new_quantity
      item_add
    else
      line_items.build(item_id: item_id, quantity: new_quantity)
    end
  end

  def checkout
    self.line_items.each { |li|
      li.item.inventory -= li.quantity
      li.item.save
    }
    self.status="submitted"
    self.save
  end
end

