require 'test_helper'

class DrainMissQueueServiceTest < ActiveSupport::TestCase
  include QueueTestData

  setup do
    @service = DrainMissQueueService.new

    create_queue_data 'misses'
  end

  test 'creates hit records' do
    assert_difference 'Miss.count', 3 do
      @service.run
    end

    misses = Miss.all.load

    TEST_DATA.reverse.each.with_index do |row, index|
      assert_record misses[index], %i(domain link_ident remote_address user_agent).zip(row)
      refute misses[index].recorded_as_hit
    end
  end
end
