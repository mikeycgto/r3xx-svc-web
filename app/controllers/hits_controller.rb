class HitsController < ApplicationController
  before_action :find_link!

  rescue_from ActiveRecord::RecordNotFound, with: :link_not_found

  def index
    @hits = @link.hits

    respond_with @hits
  end

  private

  def find_link!
    Link.where(ident: params[:id]).first!
  end
end
