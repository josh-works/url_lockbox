class LinksController < ApplicationController

  before_action :authorize

  def new
  end

  def create
    link = current_user.links.create(
              title: link_params["title"],
              url: link_params["url"]
              )
    if link.save
      flash[:success] = "created new link"
      redirect_to links_path
    else
      flash[:error] = "could not save link. please try again"
    end
  end

  def index
    @link = Link.new
    @links = current_user.links.order(created_at: :desc)
  end


  private

    def link_params
      params.require(:link).permit(:title, :url)
    end


end
