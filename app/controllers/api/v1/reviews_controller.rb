class Api::V1::ReviewsController < ApplicationController
  before_action :authenticate_user

  def index
    if @current_user.isAdmin
      render json:Review.all, status: 201
    else
      render json: Review.where(user_id: @current_user.id), status: 401
    end
  end

  def show
    render json: find_review, status:201
  end


  private
  def find_review
    Review.find(params[:id])
  end

  def params_review
    params.require(:review).permit(:rating, :message, :product_id)
  end

end
