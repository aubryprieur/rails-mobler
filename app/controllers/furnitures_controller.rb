class FurnituresController < ApplicationController

  def index
    @furnitures = policy_scope(Furniture)
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
