class RemoveReviewIdToFurnituresWishlists < ActiveRecord::Migration[5.1]
  def change
    remove_reference :furnitures_wishlists, :review
  end
end
