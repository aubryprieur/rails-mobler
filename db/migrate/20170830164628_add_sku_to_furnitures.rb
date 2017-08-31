class AddSkuToFurnitures < ActiveRecord::Migration[5.1]
  def change
    add_column :furnitures, :sku, :string
  end
end
