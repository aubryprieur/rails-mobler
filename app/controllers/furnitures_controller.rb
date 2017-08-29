class FurnituresController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @search = Search.new(search_params)
    @categories = Category.all
    @wishlist = Wishlist.new
    return @furnitures = policy_scope(Furniture).page(params[:page]) unless params[:search].present?

    if params.fetch(:search, {})[:category].present?
      @furnitures = policy_scope(Furniture).where(category: params[:search][:category],
                                                  width: (@search.min_width.present? ? @search.min_width.to_i : 0)..(@search.max_width.present? ? @search.max_width.to_i : 400),
                                                  height: (@search.min_height.present? ? @search.min_height.to_i : 0)..(@search.max_height.present? ? @search.max_height.to_i : 400),
                                                  length: (@search.min_length.present? ? @search.min_length.to_i : 0)..(@search.max_length.present? ? @search.max_length.to_i : 400)
                                                  ).page(params[:page]).order("price")
    else
      @furnitures = policy_scope(Furniture).where(width: (@search.min_width.present? ? @search.min_width.to_i : 0)..(@search.max_width.present? ? @search.max_width.to_i : 400),
                                                  height: (@search.min_height.present? ? @search.min_height.to_i : 0)..(@search.max_height.present? ? @search.max_height.to_i : 400),
                                                  length: (@search.min_length.present? ? @search.min_length.to_i : 0)..(@search.max_length.present? ? @search.max_length.to_i : 400)
                                                  ).page(params[:page]).order("price")
    end
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
    params.require(:search).permit!
  end
end
