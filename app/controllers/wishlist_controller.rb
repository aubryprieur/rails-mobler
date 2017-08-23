class WishlistController < ApplicationController

  def show


    authorize @wishlist
  end

end
