class Link < ApplicationRecord
  include Pageable

  belongs_to :user, counter_cache: true, optional: true

  has_many :hits

  before_validation :set_domain
  before_validation :set_ident

  validates :url, :domain, :ident, presence: true
  validates :ident, uniqueness: true
  validate :check_url_format

  after_create :update_redis_entry
  after_destroy :remove_redis_entry

  def shortened_url
    "https://#{domain}/#{ident}"
  end

  def to_param
    ident
  end

  def redis_key
    "#{Rails.application.config.redis_namespace}:#{domain}:#{ident}"
  end

  def self.next_ident
    loop do
      ident = SecureRandom.urlsafe_base64(4)

      break ident unless Link.where(ident: ident).exists?
    end
  end

  private

  def update_redis_entry
    Rails.application.redis_pool.with do |conn|
      conn.set redis_key, url
    end
  end

  def remove_redis_entry
    Rails.application.redis_pool.with do |conn|
      conn.del redis_key
    end
  end

  def check_url_format
    l_url = url.to_s.dup
    l_url.prepend 'http://' unless l_url =~ %r{\A\w+:}

    uri = URI.parse(l_url)

    errors.add :url, :invalid_protocol unless URI::HTTP === uri
    errors.add :url, :invalid_hostname unless uri.hostname.to_s.include? '.'
  end

  def set_ident
    self.ident ||= self.class.next_ident
  end

  def set_domain
    # NOTE for now we just hard code to r3xx.io
    self.domain ||= 'r3xx.io'
  end
end
