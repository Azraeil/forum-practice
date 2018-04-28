class Api::V1::AuthController < ApiController
  before_action :authenticate_user!, only: :logout

  # POST /api/v1/login
  def login
    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
    end

    if user && user.valid_password?(params[:password])
      render json: {
        message: "login OK",
        auth_token: user.authentication_token,
        user_id: user.id
      }
    else
      render json: { message: "Email or Password is wrong!"}, status: 401
    end
  end

  # POST /api/v1/logout
  def logout
    # 登出時刷新 token，作爲下次登入時比對用，使用者那邊舊的 token 就失效了
    current_user.generate_authentication_token
    current_user.save!

    render json: {message: "logout OK"}
  end
end
