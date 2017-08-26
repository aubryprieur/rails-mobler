class ChangeTypeIntegerToFurnitures < ActiveRecord::Migration[5.1]
  def change
    change_column :furnitures, :height, :integer
    change_column :furnitures, :width, :integer
    change_column :furnitures, :length, :integer
  end
end
