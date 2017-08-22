class FurnituresController < ApplicationController

  def index
    @furnitures = policy_scope(Furniture)
  end

  def show
    @furniture = Furniture.find(params[:id])
    authorize @furniture
  end
end
