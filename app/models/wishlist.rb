class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :furnitures_wishlists, dependent: :destroy
  has_many :furnitures, through: :furnitures_wishlists
  has_many :guest_wishlists
  has_many :donations

  validates :title, uniqueness: true, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
end
