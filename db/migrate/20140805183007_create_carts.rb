class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :status
      t.references :user
    end
  end
end
