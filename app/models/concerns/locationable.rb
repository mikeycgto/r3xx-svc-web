module Locationable
  DB_FILE = Rails.root.join('vendor', 'GeoLite2-City.mmdb').to_s.freeze

  extend ActiveSupport::Concern

  included do
    before_validation(on: :create) do
      next if remote_address.blank?

      geo = GeoIP2Compat.new(DB_FILE).lookup(remote_address)

      self.location_country_code = geo[:country_code]
      self.location_country_name = geo[:country_name]
      self.location_region_name = geo[:region_name]
      self.location_city_name = geo[:city]
    end
  end
end
