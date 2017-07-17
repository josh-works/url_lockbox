class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome to URL lockbox, #{user.email}!"
      redirect_to links_path
    else
      redirect_to authenticate_path
      # flash notice something
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
