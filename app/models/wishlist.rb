class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :furnitures_wishlists, dependent: :destroy
  has_many :furnitures, through: :furnitures_wishlists

  validates :title, uniqueness: true, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
end
