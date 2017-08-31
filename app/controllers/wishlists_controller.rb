class WishlistsController < ApplicationController
  before_action :authenticate_user!
  def show
    @categories = Category.all
    @search = Search.new(search_params)
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

  def create
    @wishlist = Wishlist.new(wishlist_params)
    @wishlist.user = current_user
    @wishlist.save
    authorize @wishlist
    redirect_back(fallback_location: root_path)
  end

  def update
    @wishlist = Wishlist.new(wishlist_params)
    @wishlist = Wishlist.find(params[:id])
    @wishlist.update(wishlist_params)
    authorize @wishlist
    redirect_back(fallback_location: root_path)
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

  def add_and_create
    @wishlist = Wishlist.new(wishlist_params)
    @wishlist.user = current_user
    @wishlist.save
    @item = FurnituresWishlist.new(furniture_id: params[:wishlist][:furniture_id], wishlist_id: @wishlist.id)
    @item.wishlist = @wishlist
    authorize @wishlist
    if @item.save
        redirect_back(fallback_location: root_path)
      else
        render :new
    end
  end


  def wishlist_params
    params.require(:wishlist).permit(:title, :description)
  end

  def search_params
    if params[:search].present?
      p = params.require(:search).permit!
      session[:search] = p
    else
      session[:search]
    end
  end
end
