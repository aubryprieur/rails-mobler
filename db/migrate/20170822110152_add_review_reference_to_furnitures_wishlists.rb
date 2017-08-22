class AddReviewReferenceToFurnituresWishlists < ActiveRecord::Migration[5.1]
  def change
    add_reference :furnitures_wishlists, :review
  end
end
