class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: %i[show update destroy]
  include JsonWebToken

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def create
  @user = User.new(user_params)
  if @user.save

    token = JsonWebToken.encode(user_id: @user.id)
    time = Time.now + 24.hours.to_i
    render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                    name: @user.name, user_name: @user.user_name, role: @user.role }, status: 200
  else
    render json: { errors: @user.errors.full_messages }, status: 503
  end
  end
end
