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

  def add_item(item_id, quantity=1)
    if line_items.find_by(item_id: item_id) 
      item_add=line_items.find_by(item_id: item_id)
      item_add.quantity+=quantity
      item_add
    else
# binding.pry
      line_items.build(item_id: item_id, quantity: quantity)
# binding.pry
    end
  end
end

=begin
@cart.line_items.build(item_id: second_item.id)

=end