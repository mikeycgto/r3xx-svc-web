require 'test_helper'

class DrainHitsQueueServiceTest < ActiveSupport::TestCase
  include QueueTestData

  setup do
    @service = DrainHitsQueueService.new

    create_queue_data 'hits'
  end

  test 'creates hit and miss records' do
    assert_difference 'Hit.count', 3 do
      @service.run
    end
  end

  test 'associates hits with links' do
    @service.run

    assert_equal [1, 1, 1], [
      links(:bob_foo).hits.count, links(:bob_bar).hits.count, links(:anon_baz).hits.count
    ]
  end

  test 'creates miss record when ident not found' do
    miss_row = %w(r3xx.io miss 1.2.3.4 chrome)

    create_queue_data 'hits', [miss_row]

    assert_difference 'Miss.count' do
      @service.run
    end

    assert_record Miss.last, %i(domain link_ident remote_address user_agent).zip(miss_row)
    assert Miss.last.recorded_as_hit
  end
end
