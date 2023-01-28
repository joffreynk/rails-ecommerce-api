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

  def create
    review = Review.new(user_id:@current_user.id, *review_params)
    if @eview.save
      render json: review, status: 201
    else render json: {error: 'ooops verify your data'}, status: 201
  end

  def update
    if @current_user.id == find_review.user_id
      if find_review.update(review_params)
        render json: review, status: 201
      end
    end
  end

  def destroy
    if @current_user.isAdmin || @current_user.id == find_review.user_id
      if find_review.destroy
        render json: {message: 'Review deleted successfully'}, status: 201
      end
    else
      render json: {error: 'You are not allowed to delete this review'}, status: 401
    end
  end

  def confirm_review
    if @current_user.isAdmin
      find_review.update(reviewConfirmed: true)
      render json: {message: 'Review confirmed successfully'}, status: 201
    else
      render json: {error: 'You are not allowed to confirm this review'}, status: 401
    end
  end



  private
  def find_review
    Review.find(params[:id])
  end

  def params_review
    params.require(:review).permit(:rating, :message, :product_id)
  end

end
