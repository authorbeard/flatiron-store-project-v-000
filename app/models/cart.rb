class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  enum status: [:current, :submitted]
  before_create :set_default_status

  def set_default_status
    self.status||="current"
  end

  def total
    line_items.collect{|l| l.subtotal}.reduce(:+)
  end 

  def add_item(item_id, new_quantity=1)
# binding.pry
    if id.nil?
      self.save
      line_items.create(item_id: item_id)
      self.save
    else
# binding.pry
      if has_item?(item_id)
binding.pry
        q=line_items.find_by(item_id: item_id).quantity+=new_quantity
        line_items.find_by(item_id: item_id).update(quantity: q)
      else
        line_items.create(item_id: item_id)
      end

      
    end

  end

  def checkout
    self.line_items.each { |li|
      li.item.inventory -= li.quantity
      li.item.save
    }
    self.status="submitted"
# binding.pry
    self.save
  end

  def has_item?(item_id)
    items.include?(Item.find(item_id))
  end


end

