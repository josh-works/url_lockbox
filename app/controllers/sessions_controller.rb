class SessionsController < ApplicationController


  def create
    
  end

  private

    def session_params
      params.require(:user).permit(:email, :password)
    end

end
