require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html

  protected

  def page_params
    params.permit(:page_number, :page_size)
  end

  helper_method :page_params
end
