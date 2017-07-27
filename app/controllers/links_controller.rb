class LinksController < ApplicationController

  before_action :authorize

  def new
  end

  def create
    link = current_user.links.create(link_params)
    if link.save
      flash[:success] = "created new link"
      redirect_to links_path
    else
      if link.errors.any?
        link.errors.each do |attribute, message|
          flash[:error] = "#{attribute.to_s} #{message}"
        end
      end
      redirect_back(fallback_location: links_path)
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
