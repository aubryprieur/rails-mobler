class ProfilesController < ApplicationController
  def profile
    @categories = Category.all
    @wishlist = Wishlist.new
    @wishlists = current_user.wishlists
    @FirstName = current_user.first_name
    @LastName = current_user.last_name
    @avatar = current_user.photo
    @email = current_user.email
    @guest_wishlist = GuestWishlist.new
    @guest_wishlists = current_user.guest_wishlists
    authorize :profile
  end

end
