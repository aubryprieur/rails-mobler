class FurnituresController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :destroy]


  def index
    @search = Search.new(search_params)
    @categories = Category.all
    @wishlist = Wishlist.new

    session[:search] = params[:search] if params[:search].present?
    request = policy_scope(Furniture)


    return @furnitures = request.page(params[:page]) unless session[:search].present?

    request = request.where(category: session[:search]['category']) if session[:search]['category'].present?
    request = request.where(
      width: (@search.min_width.present? ? @search.min_width.to_i : 0)..(@search.max_width.present? ? @search.max_width.to_i : 400),
      height: (@search.min_height.present? ? @search.min_height.to_i : 0)..(@search.max_height.present? ? @search.max_height.to_i : 400),
      length: (@search.min_length.present? ? @search.min_length.to_i : 0)..(@search.max_length.present? ? @search.max_length.to_i : 400)
    )
    @furnitures = request.page(params[:page])
  end

  def show
    @wishlist = Wishlist.new
    @furniture = Furniture.find(params[:id])
    authorize @furniture
  end

  def destroy
    @furniture = Furniture.find(params[:id])
    authorize @furniture
    if @furniture.destroy
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  private

  def search_params
    if params[:search].present?
      p = params.require(:search).permit!
      session[:search] = p
    else
      session[:search]
    end
  end
end
