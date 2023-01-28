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

  def show
    render json: find_order_by_id, status: :201
  end

  def create
    order = Order.new(user_id:@current_user.id, *order_params)
    if order.save
      render json: order, status: :created
    end
    render json: {error: order.errors.full_messages}, status: :404
  end

  def update
    order = Order.update(user_id:@current_user.id, *order_params)
    if order.update(order_params)
      render json: order, status: :ok
    end
    render json: {error: order.errors.full_messages}, status: :404
  end

  def destroy
    if find_order_by_id.destroy
      render json: {success: true}, status: :201
    end
  end

  def confirm_order
    if @current_user.isAdmin
      order = find_order_by_id.update(orderConfirmed:true)
      render json: order, status: 201
    end
    render json: {error: 'ooops, you don\'t have access to confirn an order'}, status: 404
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
