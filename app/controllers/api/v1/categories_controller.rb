class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user
  
  def index
    render json: Category.order(created_at: :desc)
  end

  def show
    render json: find_category(), status: 201
  end

  def create
    if @current_user.isAdmin
      category = Category.new(catagory_params())
      if category.save
        render json: category, status: 201
      end
    else
      render json: {error: 'you are not allowed to create a category'}, status: 404
    end
  end


  def update
    if @current_user.isAdmin
      category = find_category.update(catagory_params())
      render json: category, status: 201
    else
      render json: {error: 'you are not allowed to create a category'}, status: 404
    end
  end

  def destroy
    if @current_user.isAdmin
      find_category.destroy
      render json: {message: 'category destroyed successfully'}, status: 200
    end
  end

  private
  def catagory_params
    params.require(:category).permit(:name, :description);
  end

  def find_category
    Category.find(params[:id])
  end

end
