class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    if @current_user.isAdmin
      render json: Order.all, status: :ok
    end
    if !@current_user.isAdmin
      render json: find_orders_by_user_id, status: :ok
    end
    render json: {error: 'ooops, no orders was made'}, status: 404
  end

  private
  def find_orders_by_user_id
    Order.find(@current_user.id)
  end
  
end
