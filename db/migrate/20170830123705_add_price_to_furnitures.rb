class AddPriceToFurnitures < ActiveRecord::Migration[5.1]
  def change
    add_monetize :furnitures, :price, currency: { present: false }
  end
end
