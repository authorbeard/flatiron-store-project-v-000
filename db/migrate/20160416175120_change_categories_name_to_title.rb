class ChangeCategoriesNameToTitle < ActiveRecord::Migration
  def change
    remove_column :categories, :name, :string
    add_column :categories, :title, :string
  end
end
