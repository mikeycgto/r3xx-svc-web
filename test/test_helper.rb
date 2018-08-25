require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

module QueueTestData
  extend ActiveSupport::Concern

  TEST_DATA = [
    %w(r3xx.io foo 1.2.3.4 chrome),
    %w(r3xx.io bar 5.6.7.8 chrome),
    %w(r3xx.io baz 9.1.0.2 msie)
  ]

  included do
    teardown do
      next unless defined? @queues

      @queues.each do |queue_name|
        Rails.application.redis_pool.with { |conn| conn.del queue_name }
      end
    end
  end

  def create_queue_data(name, rows = TEST_DATA)
    queue_name = "r3xx:#{name}"

    @queues ||= Set.new
    @queues << queue_name

    Rails.application.redis_pool.with do |conn|
      rows.each { |row| conn.lpush queue_name, JSON.dump(row) }
    end
  end

  def assert_record(record, attributes)
    attributes.each do |key, value|
      assert_equal record[key], value
    end
  end
end
