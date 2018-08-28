class Hit < ApplicationRecord
  include DeviceDetectable
  include Locationable

  belongs_to :link, counter_cache: true

  validates :remote_address, :user_agent, presence: true
end
