class AddFurnituresWishlistReferenceToreviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :furnitures_wishlist
  end
end
