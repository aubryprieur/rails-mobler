class WishlistController < ApplicationController

  def show
    @wishlist = Wishlist.find(params[:id])
    @furnitures = @wishlist.furnitures
    authorize @wishlist
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy
    authorize @wishlist
    redirect_to profile_path
  end

  def add_item
    @wishlist = Wishlist.find(params[:wishlist_id])
    @item = FurnituresWishlist.new(furniture_id: params[:furniture_id], wishlist_id: params[:wishlist_id])
    @item.wishlist = Wishlist.find(params[:wishlist_id])
    authorize @wishlist
      if @item.save
        redirect_back(fallback_location: root_path)
      else
        render :new
      end
  end

  def review_params
    params.require(:furniture_id).permit(:id)
  end
end
