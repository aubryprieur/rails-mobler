class FurnituresController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @categories = Category.all
    @wishlist = Wishlist.new
    if params[:search][:category].present?
      @furnitures = policy_scope(Furniture).where(category: params[:search][:category],
                                                  width: (params[:search][:min_width].present? ? params[:search][:min_width].to_i : 0)..(params[:search][:max_width].present? ? params[:search][:max_width].to_i : 400),
                                                  height: (params[:search][:min_height].present? ? params[:search][:min_height].to_i : 0)..(params[:search][:max_height].present? ? params[:search][:max_height].to_i : 400),
                                                  length: (params[:search][:min_length].present? ? params[:search][:min_length].to_i : 0)..(params[:search][:max_length].present? ? params[:search][:max_length].to_i : 400)
                                                  ).page(params[:page]).order("price")
    else
      @furnitures = policy_scope(Furniture).where(width: (params[:search][:min_width].present? ? params[:search][:min_width].to_i : 0)..(params[:search][:max_width].present? ? params[:search][:max_width].to_i : 400),
                                                  height: (params[:search][:min_height].present? ? params[:search][:min_height].to_i : 0)..(params[:search][:max_height].present? ? params[:search][:max_height].to_i : 400),
                                                  length: (params[:search][:min_length].present? ? params[:search][:min_length].to_i : 0)..(params[:search][:max_length].present? ? params[:search][:max_length].to_i : 400)
                                                  ).page(params[:page]).order("price")
    end
  end



  def show
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
