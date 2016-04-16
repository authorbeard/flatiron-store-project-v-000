class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :item
      t.references :cart
      t.integer :quantity

    end
  end
end
