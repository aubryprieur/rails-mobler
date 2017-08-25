class ChangeTypeToFurnitures < ActiveRecord::Migration[5.1]
  def change
    change_column :furnitures, :height, :integer, using: 'height::integer'
    change_column :furnitures, :width, :integer, using: 'width::integer'
    change_column :furnitures, :length, :integer, using: 'length::integer'
  end
end
