class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.float :price
      t.integer :inventory
      t.references :category
    end
  end
end
