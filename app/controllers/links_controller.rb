class LinksController < ApplicationController
  LinkNotInSession = Class.new(StandardError)

  self.responder = ApplicationResponder::CollectionResponder

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
    links = Link.where(id: session[:link_idents]) if session.key? :link_idents
    links.blank? ? links : nil
  end

  def create_link_from_current_user_or_session
    if current_user then current_user.links.create(link_params)
    else
      Link.create(link_params).tap do |link|
        session[:link_idents] ||= []
        session[:link_idents] << link.ident
      end
    end
  end

  def find_link_from_current_user_or_session
    @link = find_link_from_current_user || find_link_from_session
  rescue ActiveRecord::RecordNotFound, LinkNotInSession
    redirect_to links_url, flash: { alert: 'Failed to find Link resource' }
  end

  def find_link_from_current_user
    current_user.links.where(ident: params[:id]).first! if current_user.present?
  end

  def find_link_from_session
    raise LinkNotInSession if session[:link_idents].blank?
    raise LinkNotInSession unless params[:id].in? session[:link_idents]

    Link.where(ident: params[:id]).first!
  end
end
