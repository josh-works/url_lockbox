class LinksController < ApplicationController

  before_action :authorize

  def index
    @links = current_user.links
  end

end
