class FurnituresWishlist < ApplicationRecord
  belongs_to :wishlist
  belongs_to :furniture
  has_many :reviews
end
