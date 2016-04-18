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

  def add_item(item_id)
    if id.nil?
      self.save
      line_items.create(item_id: item_id)
      self.save
    else
      if has_item?(item_id)
        update_quantity(item_id)
      else
        line_items.build(item_id: item_id, quantity: 1)
      end
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

  def has_item?(item_id)
    items.include?(Item.find(item_id))
  end

  def update_quantity(item_id)
    li=line_items.find_by(item_id: item_id)
    q=li.quantity+=1
    li.update(quantity: q)
    li
  end


end

