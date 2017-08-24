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

#A configurer en récupérant les infos de la modale popup dans l'index de furnitures
  # def create
  #   @wishlist = Wishlist.new
  #   @wishlist.user = current_user
  #   @wishlist.save
  # end
end
