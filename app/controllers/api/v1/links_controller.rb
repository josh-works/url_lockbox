class Api::V1::LinksController < ApplicationController


  def create
    @link = current_user.links.new(new_link_params)
    if @link.update_attributes(new_link_params)
      render partial: 'partials/single_new_link', locals: {link: @link}, layout: false
    else
      render json: @link.errors.full_messages, status: 500
    end
  end


  def update
    @link = current_user.links.find(params[:id])
    if @link.update_attributes(link_params)
      render json: @link
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  private

  def link_params
    params.permit(:title, :url, :id)
  end

  def new_link_params
    params.require(:link).permit(:title, :url)
  end
end



# link = current_user.links.create(link_params)
# if link.save
#   flash[:success] = "created new link"
#   redirect_to links_path
# else
#   if link.errors.any?
#     link.errors.each do |attribute, message|
#       flash[:error] = "#{attribute.to_s} #{message}"
#     end
#   end
#   redirect_back(fallback_location: links_path)
# end
