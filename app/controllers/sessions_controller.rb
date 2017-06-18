class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      login_user!(user)
    else
      flash.now[:error] = "There is something wrong with your username or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = "You have successfully logged in"
    redirect_to root_path
  end

end