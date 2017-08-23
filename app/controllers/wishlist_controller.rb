class WishlistController < ApplicationController

  def show
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
  end

end
