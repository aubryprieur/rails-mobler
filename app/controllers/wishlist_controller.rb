class WishlistController < ApplicationController

  def show
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
  end

#A configurer en récupérant les infos de la modale popup dans l'index de furnitures
  def create
    @wishlist = Wishlist.new
    @wishlist.user = current_user
    @wishlist.save
  end
end
