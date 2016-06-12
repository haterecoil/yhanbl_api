class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    authorize @users

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(new_user_params)
    authorize @user

    if (@user.password_confirmation.nil?)
      @user.password_confirmation = @user.password
    end

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize @user
    @user.destroy

    head :no_content
  end

  # GET /users/1/friends
  def get_friends
    @user = User.find(params[:id])
    authorize @user
    @users = User.friends_of(@user)

    render json: @users
  end

  private

    def pundit_user
      @current_user
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:username)
    end

    def new_user_params
      params.permit(:username, :password, :password_confirmation, :email)
    end
end
