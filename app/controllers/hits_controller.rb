class HitsController < ApplicationController
  before_action :find_link!

  rescue_from ActiveRecord::RecordNotFound, with: :link_not_found

  def index
    @hits = @link.hits

    respond_with @hits
  end

  private

  def find_link!
    @link = Link.where(ident: params[:link_id]).first!
  end
end
