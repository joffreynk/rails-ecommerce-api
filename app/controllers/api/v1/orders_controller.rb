class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    if @current_user.isAdmin
      render json: Order.all, status: 201
    else
      render json: Order.where(user_id: @current_user.id), status: 201
    end
  end

  def show
    render json: find_order_by_id, status: 201
  end

  def create
    order = Order.new(user_id:@current_user.id, **order_params)
    if order.save
      render json: order, status: 201
    else
      render json: {message: order.errors.full_messages}, status: 401
    end
  end

  def update
    if find_order_by_id.update(user_id:@current_user.id, **order_params)
      render json: find_order_by_id, status: 201
    else
      render json: {message: find_order_by_id.errors.full_messages}, status: 401
    end
  end

  def destroy
    if find_order_by_id.destroy
      render json: {message: 'order destroyed successfully'}, status: 201
    end
  end

  def confirm_order
    if @current_user.isAdmin
      find_order_by_id.update(orderConfirmed:true)
      render json: find_order_by_id, status: 201
    else
      render json: {message: 'ooops, you don\'t have access to confirn an order'}, status: 404
    end
  end

  private
  def find_orders_by_user_id
    Order.where(user_id: @current_user.id)
  end

  def find_order_by_id
    Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:numberOfItems, :totalPrice, :product_id, :shippingLocation)
  end

end
