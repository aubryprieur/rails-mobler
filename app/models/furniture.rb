class Furniture < ApplicationRecord
  belongs_to :category
  has_many :wishlists, through: :furnitures_wishlists
end
