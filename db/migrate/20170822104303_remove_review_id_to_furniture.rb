class RemoveReviewIdToFurniture < ActiveRecord::Migration[5.1]
  def change
    remove_reference :furnitures, :review
  end
end
