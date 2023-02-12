class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: %i[show update destroy]
  include JsonWebToken

  def index
    if @current_user.isAdmin
      render json: UserSerializer.new(User.all).serializable_hash[:data].map {|user| user[:attributes]}, status: 200
    else
      render json: UserSerializer.new(@current_user).serializable_hash[:data][:attributes], status: 201
    end
  end

  def create
    user = User.new(user_params)
    if user.save

      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 720.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'), email: user.email, isAdmin: user.isAdmin }, status: 200
    else
      render json: { message: user.errors.full_messages }, status: 401
    end
  end

  def show
    render json: UserSerializer.new(find_user).serializable_hash[:data][:attributes], status: 201
  end

  def update
    if @current_user.isAdmin || find_user.user_id==@current_user.id
      if find_user.update(user_params)
        render json: UserSerializer.new(find_user).serializable_hash[:data][:attributes] , status: 200
      else
        render json: { message: user.errors.full_messages }, status:404
      end
    else
      render json: { message: 'You are not eligable to delete this user'}, status:404
    end

  end

  def destroy
    if @current_user.isAdmin
      if find_user.destroy
        render json: { message: 'User is deleted' }, status: 201
      else
        render json: { message: 'oops! user is not deleted' }, status: 401
      end
    else
      @current_user.destroy(user_params)
      render json: { message: 'You have deleted you aaccount, please register again' }, status: 200
    end
  end

  private
  def find_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:firstName, :lastName, :email, :password_digest, :phoneNumber, :address, :password, :dob, :isAdmin, :profile_picture)
  end
end
