class Link < ApplicationRecord
  belongs_to :user, counter_cache: true

  before_validation :set_ident

  validates :url, :ident, presence: true
  validates :ident, uniqueness: true

  private

  def set_ident
    self.ident ||= SecureRandom.urlsafe_base64(6)
  end
end
