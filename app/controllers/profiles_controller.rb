class ProfilesController < ApplicationController
  def profile
    @wishlists = current_user.wishlists
    @FirstName = current_user.first_name
    @LastName = current_user.last_name
    @avatar = current_user.photo
    @email = current_user.email
    authorize :profile
  end

end
