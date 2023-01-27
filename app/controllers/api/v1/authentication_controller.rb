class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user, except: :login
    include JsonWebToken

    # POST /auth/login
    def login
      user = User.find_by(user_name: params[:user_name])
      if user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: user.id)
        time = Time.now + 24.hours.to_i
        render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                        name: user.name, user_name: user.user_name, role: user.role }, status: :ok
      else
        render json: { error: 'unauthorized user, please register or contact your admin' }, status: :unauthorized
      end
    end

    def logout; end

    private

    def login_params
      params.permit(:user_name, :password)
    end
end
