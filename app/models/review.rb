class Review < ApplicationRecord
  belongs_to :furnitures_wishlist
  belongs_to :user

  validates :content, presence: true
end
