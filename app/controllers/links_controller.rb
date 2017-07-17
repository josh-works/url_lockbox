class LinksController < ApplicationController

  def index
    if current_user
      @links = Link.all
    else
      redirect_to authenticate_path
    end
  end

end
