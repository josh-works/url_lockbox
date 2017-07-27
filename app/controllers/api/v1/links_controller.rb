class Api::V1::LinksController < ApplicationController

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
    params.permit(:read, :id)
  end
end
