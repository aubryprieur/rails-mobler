class Donation < ApplicationRecord
  belongs_to :wishlist

  monetize :amount_cents
end
