class LinksController < ApplicationController
  include Responders::CollectionResponder

  before_action :find_link_from_current_user_or_session, only: %i(edit update destroy)

  def index
    @links = links_from_current_user || links_from_session || []

    respond_with @links
  end

  def new
    @link = Link.new

    respond_with @link
  end

  def create
    @link = create_link_from_current_user_or_session

    respond_with @link
  end

  def update
    @link.update(link_params)

    respond_with @link
  end

  def destroy
    @link.destroy

    respond_with @link
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def links_from_current_user
    links = Link.where(user: current_user)
    links.any? ? links : nil
  end

  def links_from_session
    links = Link.where(id: session[:link_ids]) if session.key? :link_ids
    links.blank? ? links : nil
  end

  def create_link_from_current_user_or_session
    if current_user then current_user.links.create(link_params)
    else
      Link.create(link_params).tap do |link|
        session[:link_ids] ||= []
        session[:link_ids] << link.id
      end
    end
  end

  def find_link_from_current_user_or_session
    if current_user then current_user.links.where(ident: params[:id])
    else
      Link.where(ident: params[:id]) if session[:link_ids].try(:includes?, params[:id])
    end
  end
end
