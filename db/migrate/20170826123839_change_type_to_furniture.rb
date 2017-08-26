class ChangeTypeToFurniture < ActiveRecord::Migration[5.1]
  def change
    change_column :furnitures, :height, :float
    change_column :furnitures, :width, :float
    change_column :furnitures, :length, :float
    change_column :furnitures, :price, :float, using: "price::double precision"
  end
end
