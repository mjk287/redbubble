class AuthController < ApplicationController
  def create
    @user = User.find(email: auth_params[:email])
    if @user && @user.authenticate(auth_params[:password])
      token = JWT.encode({user_id: @user.id}, "secret")
      render json: {user: @user, jwt: token}, status: :accepted
    else
      render json: {"Invalid email or password"}, status: :unauthorized
    end
  end

  def show
    user_id = JWT.decode(request.headers["Authorization"], nil, false)[0]["user_id"]
    user = User.find(user_id)
    render json: {user: user}
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

end
