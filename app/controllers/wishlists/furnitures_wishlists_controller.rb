class Wishlists::FurnituresWishlistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @wishlist = Wishlist.find(params[:wishlist_id])
    @furniture = @wishlist.furnitures.find(params[:id])
    @furnitures_wishlist = @wishlist.furnitures_wishlists.find_by(furniture: @furniture)
    authorize @furnitures_wishlist
  end

  def destroy
    @furniture = @wishlist.furnitures.find(params[:id])
    @furnitures_wishlist = @wishlist.furnitures_wishlists.find_by(furniture: @furniture)
    @furnitures_wishlist.destroy
    redirect_to profile_path
    authorize @furnitures_wishlist
  end
end
