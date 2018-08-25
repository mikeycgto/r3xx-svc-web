class Hit < ApplicationRecord
  belongs_to :link, counter_cache: true

  validates :domain, presence: true
end
