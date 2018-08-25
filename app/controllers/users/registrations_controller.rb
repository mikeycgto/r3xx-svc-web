class Users::RegistrationsController < Devise::RegistrationsController
  after_action :convert_session_links, on: :create

  private

  def convert_session_links
    if resource.persisted? && session.key?(:link_idents)
      session[:link_idents].each do |ident|
        link = Link.where(ident: ident).first
        link&.update(user_id: resource.id)
      end
    end
  end
end
