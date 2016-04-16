class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  enum status: [:current, :submitted]
  before_create :set_default_status

  def set_default_status
    self.status="current"
  end

  ## method to calculate total:
  ## Would grab line-items and multiply quantity by price
  ## problem: quantity is on line-items, and price is on items
  ## prob need helper methods
  ## don't need DB column for that. 

end
