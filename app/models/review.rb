class Review < ApplicationRecord
  belongs_to :furnitures_wishlist

  validates :content, presence: true
end
