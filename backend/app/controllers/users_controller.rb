class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @token = JWT.encode({user_id: @user.id}, "secret")
      render json: {user: @user, jwt: @token}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :username)
  end
end
