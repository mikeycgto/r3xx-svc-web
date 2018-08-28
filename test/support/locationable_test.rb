module LocationableTest
  extend ActiveSupport::Concern

  included do
    test 'locationable sets location country code' do
      assert_equal 'US', locationable_record.location_country_code
    end

    test 'locationable sets location country name' do
      assert_equal 'United States', locationable_record.location_country_name
    end

    test 'locationable sets location region name' do
      assert_equal 'New Hampshire', locationable_record.location_region_name
    end

    test 'locationable sets location city name' do
      assert_equal 'Londonderry', locationable_record.location_city_name
    end
  end

  def locationable_record
    @model_class.new(remote_address: '75.68.28.12').tap(&:valid?)
  end
end
