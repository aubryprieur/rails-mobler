class Furniture < ApplicationRecord
  belongs_to :category
  has_many :furnitures_wishlists
  has_many :wishlists, through: :furnitures_wishlists, dependent: :destroy

  validates :title, uniqueness: true, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :height, presence: true
  validates :width, presence: true
  validates :lenght, presence: true
  validates :price, presence: true
  validates :url, presence: true

end
