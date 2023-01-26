class Api::V1::ProductsController < ApplicationController
    before_action :authenticate_user

    # GET /api/v1/products
    def index
        @products = Product.all
        render json: @products, status: :ok
    end


    private
    def product_params
        params.require(:product).permit(:name, :description, :price, :category_id, :user_id)
    end
end
