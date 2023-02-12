class Api::V1::ProductsController < ApplicationController
    before_action :authenticate_user
    skip_before_action :authenticate_user, only: [:index]

    # GET /api/v1/products
    def index
        # render json: Product.all, status: :ok
        render json:  ProductSerializer.new(Product.order('created_at DESC')).serializable_hash[:data].map { |product| product[:attributes]}, status: 200
    end

    def create
        if @current_user.isAdmin
            product = Product.new(user_id: @current_user.id, **product_params)
            if product.save
                render json:  ProductSerializer.new(product).serializable_hash[:data][:attributes], status: 201
            else
                render json: product.errors, status: 401
            end
        else
            render json: {message: 'you are not allowed to create a product, please contact your administrator'}, status: 401
        end
    end

    def show
      render json:  ProductSerializer.new(find_product).serializable_hash[:data][:attributes], status: 201
    end

    def update
      if @current_user.isAdmin
        product = find_product.update(product_params)
        if product
          render json:  ProductSerializer.new(product).serializable_hash[:data][:attributes], status: 201
        else
          render json: {message: 'ooops, your category is not updated'}, status: 404
        end
      else
          render json: {message: 'you are not allowed to edit a product, please contact your administrator'}, status: 401
      end
    end

    def destroy
      if @current_user.isAdmin
        product = find_product.destroy
        render json:  {message: 'Product deleted success fully'}, status: 401
      else
          render json: {message: 'you are not allowed to edit a product, please contact your administrator'}, status: 401
      end
    end



    private
    def product_params
      puts params
        params.require(:product).permit(:name, :description, :price, :category_id, :product_picture)
    end

    def find_product
      Product.find(params[:id])
    end
end
