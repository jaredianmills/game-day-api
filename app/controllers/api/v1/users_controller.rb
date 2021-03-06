class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :find_user, only: [:show, :update]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      collection = Collection.new
      collection.user = @user
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: @user.errors.full_messages }
    end
  end

  def update
    if user_params[:username] == ''
      render json: { error: "Username cannot be blank" }
      return
    end

    found_user = User.find_by(username: user_params[:username])

    if found_user && found_user.id != user_params[:id]
      render json: { error: "That username is already in use" }
      return
    end

    @user.username = user_params[:username]
    @user.bgg_username = user_params[:bgg_username]

    if @user.valid?
      @user.save
      render json: @user
    else
      render json: { error: @user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :bgg_username)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
