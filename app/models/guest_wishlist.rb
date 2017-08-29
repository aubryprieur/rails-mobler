class GuestWishlist < ApplicationRecord
  before_validation :set_user_id, if: :email?

  belongs_to :user
  belongs_to :wishlist

  def set_user_id
  existing_user = User.find_by(email: email)
  self.user = if existing_user.present?
                existing_user
              else
                User.invite!(email: email)
              end
end
end
