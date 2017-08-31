class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @categories = Category.all
    @search = Search.new(search_params)
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
