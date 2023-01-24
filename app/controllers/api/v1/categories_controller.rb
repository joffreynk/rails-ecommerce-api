class Api::V1::CategoriesController < ApplicationController
  def index
    render json: Category.all
  end
end
