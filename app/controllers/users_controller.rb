class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created successfully!"
      redirect_to users_path
    else
      flash[:error] = "Please fix the problems below."
      render :new
    end
  end

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      flash[:error] = "Please fix the problems below."
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end