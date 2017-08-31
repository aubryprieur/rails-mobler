class AddFurnitureSkuToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :furniture_sku, :string
  end
end
