require 'test_helper'

class DrainQueueServiceTest < ActiveSupport::TestCase
  include QueueTestData

  setup do
    @service = DrainQueueService.new(:test_queue)

    create_queue_data 'test_queue'
  end

  test '#call yeilds with parsed json' do
    entries = [].tap do |entries|
      @service.call { |e| entries << e }
    end

    assert_equal entries, TEST_DATA.reverse
  end
end
