class Api::V1::CategoriesController < ApplicationController
  def index
    render json: Category.all
  end

  private
  def catagory_params
    params.require(:category).permit(:name, :description);
  end
end
