class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :furnitures, through: :furnitures_wishlists
end
