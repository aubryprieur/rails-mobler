class FurnituresController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :destroy]


  def index
    @categories = Category.all
    @wishlist = Wishlist.new

    session[:search] = params[:search] if params[:search].present?
    request = policy_scope(Furniture)

    return @furnitures = request.page(params[:page]) unless session[:search].present?

    request = request.where(category: session[:search]['category']) if session[:search]['category'].present?
    request = request.where(
      width: (session[:search]['min_width'].present? ? session[:search]['min_width'].to_i : 0)..(session[:search]['max_width'].present? ? session[:search]['max_width'].to_i : 400),
      height: (session[:search]['min_height'].present? ? session[:search]['min_height'].to_i : 0)..(session[:search]['max_height'].present? ? session[:search]['max_height'].to_i : 400),
      length: (session[:search]['min_length'].present? ? session[:search]['min_length'].to_i : 0)..(session[:search]['max_length'].present? ? session[:search]['max_length'].to_i : 400)
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
end
