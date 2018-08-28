module DeviceDetectableTest
  extend ActiveSupport::Concern

  included do
    test 'device detectable sets client browser name' do
      assert_equal 'Chrome Mobile', device_detectable_record.client_browser_name
    end

    test 'device detectable sets client browser version' do
      assert_equal '64.0.3282.137', device_detectable_record.client_browser_version
    end

    test 'device detectable sets client device name' do
      assert_equal 'Pixel', device_detectable_record.client_device_name
    end

    test 'device detectable sets client device type' do
      assert_equal 'smartphone', device_detectable_record.client_device_type
    end

    test 'device detectable sets client os name' do
      assert_equal 'Android', device_detectable_record.client_os_name
    end

    test 'device detectable sets client os version' do
      assert_equal '8.1.0', device_detectable_record.client_os_version
    end
  end

  private

  def device_detectable_user_agent
    'Mozilla/5.0 (Linux; Android 8.1.0; Pixel Build/OPM1.171019.012) AppleWebKit/537.36 '\
      '(KHTML, like Gecko) Chrome/64.0.3282.137 Mobile Safari/537.36'
  end

  def device_detectable_record
    @model_class.new(user_agent: device_detectable_user_agent).tap(&:valid?)
  end
end
