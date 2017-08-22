class CreateFurnituresWishlists < ActiveRecord::Migration[5.1]
  def change
    create_table :furnitures_wishlists do |t|
      t.references :wishlist, foreign_key: true
      t.references :furniture, foreign_key: true

      t.timestamps
    end
  end
end
