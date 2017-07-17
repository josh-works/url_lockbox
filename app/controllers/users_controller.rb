class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome to URL lockbox, #{user.email}!"
      redirect_to links_path
    else
      if user.errors.any?
        user.errors.each do |attribute, message|
          flash[:error] = "#{attribute.to_s} #{message}"
        end
      end
      redirect_to authenticate_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
