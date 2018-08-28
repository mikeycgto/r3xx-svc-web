class Miss < ApplicationRecord
  include DeviceDetectable
  include Locationable

  validates :link_ident, :domain, :remote_address, :user_agent, presence: true
end
