class ProfilesController < ApplicationController

  def profile
    @wishlists = current_user.wishlists
    authorize :profile
  end
end
