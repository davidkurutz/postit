class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @posts = Post.where(creator: @user)
    @comments = Comment.where(creator: @user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You are registered"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You have been updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :time_zone, :phone)
  end
end