class Wishlistwishlist_itemsController < ApplicationController
  def create
    @wishlist = Wishlist.find(params[:wishlist_id])
    @wishlist_item = WishlistItem.new(review_params)
    @wishlist_item.wishlist = Wishlist.find(params[:wishlist_id])
    @wishlist_item.user = current_user
      if @wishlist_item.save
        redirect_to(:back)
      else
        render :new
      end
  end

  private

  def review_params
    params.require(:furniture_id).permit(:id)
  end
end
