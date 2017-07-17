class SessionsController < ApplicationController


  def create

    user = User.find_by(email: session_params["email"])
    if user && user.authenticate(session_params["password"])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.email}!"

      redirect_to links_path
    else
      flash[:error] = "invalid credentials. please try again"
      redirect_back(fallback_location: root_path)
    end

  end

  private

    def session_params
      params.require(:user).permit(:email, :password)
    end

end
