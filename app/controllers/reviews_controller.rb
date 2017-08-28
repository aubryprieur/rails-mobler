class ReviewsController < ApplicationController


  def create

    @review = Review.new(review_params)
    # @furniture = Furniture.find(furniture)
    # @review.furniture = Furniture.find(params[:furniture_id])
    authorize @review
    if @review.save
      redirect_back(fallback_location: root_path)
    else
      redirect_to root_path
    end
  end


private

  def review_params
    params.require(:review).permit(:content)
  end
end
