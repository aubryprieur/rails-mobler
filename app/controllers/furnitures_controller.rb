class FurnituresController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    if params[:search][:category] != ""
      @furnitures = policy_scope(Furniture).where(category: params[:search][:category])
    else
      @furnitures = policy_scope(Furniture)
    end
  end

  def show
    @furniture = Furniture.find(params[:id])
    authorize @furniture
  end

  def destroy
    @furniture = Furniture.find(params[:id])
    authorize @furniture
    @furniture.destroy
    redirect_to profile_path
  end
end
