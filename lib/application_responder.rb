class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder

  class CollectionResponder < ApplicationResponder
    include Responders::CollectionResponder
  end
end
