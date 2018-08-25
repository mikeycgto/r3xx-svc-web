class HomeController < ApplicationController
  layout 'root'

  def index
    redirect_to links_url if current_user.present?

    @link = Link.new
  end
end
