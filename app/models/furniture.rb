class Furniture < ApplicationRecord
  belongs_to :category
  has_many :furnitures_wishlists
  has_many :wishlists, through: :furnitures_wishlists, dependent: :destroy

  scope :category, -> (category) { where category: category }

  validates :title, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :height, presence: true
  validates :width, presence: true
  validates :length, presence: true
  validates :price, presence: true
  validates :url, presence: true

end
