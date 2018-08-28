module DeviceDetectable
  extend ActiveSupport::Concern

  included do
    before_validation(on: :create) do
      next if user_agent.blank?

      client = DeviceDetector.new(user_agent)

      self.client_browser_name = client.name
      self.client_browser_version = client.full_version
      self.client_device_name = client.device_name
      self.client_device_type = client.device_type
      self.client_os_name = client.os_name
      self.client_os_version = client.os_full_version
    end
  end
end
