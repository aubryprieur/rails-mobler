class Category < ApplicationRecord
  has_many :furnitures, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
