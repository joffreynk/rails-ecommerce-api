class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user, except: :login
    include JsonWebToken

    # POST /auth/login
    def login
      @user = User.find_by(email: params[:email])
      if @user&.authenticate(params[:password_digest])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 720.hours.to_i
        render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'), email: @user.email, isAdmin: @user.isAdmin }, status: :ok
      else
        render json: { error: 'Do you have an account?, please register or contact your admin ' }, status: :unauthorized
      end
    end

    def logout; end

    private

    def login_params
      params.permit(:email, :password_digest)
    end
end
