class Api::V1::CategoriesController < ApplicationController
  def index
    render json: Category.all
  end

  def show
    render json: Category.find(params[:id])
  end

  def create
    @category = Category.new(catagory_params())
    if @category.save
      render json: @category, status: :created
    end
  end

  private
  def catagory_params
    params.require(:category).permit(:name, :description);
  end

end
