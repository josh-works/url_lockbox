class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(session_params["email"])
    if user && user.authenticate(session_params["password"])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.email}!"
      redirect_to links_path
    else
      flash[:error] = "invalid credentials. please try again"
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:success] = "You have been signed out"
  end

  private

    def session_params
      params.require(:user).permit(:email, :password)
    end

end
