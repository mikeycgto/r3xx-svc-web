class DrainQueueService
  delegate :redis_pool, :redis_namespace, to: 'Rails.application'

  def initialize(queue_name)
    @redis_key = "#{redis_namespace}:#{queue_name}"
  end

  def call
    loop do
      entry = pop_and_parse_next_entry

      break unless entry
      yield entry
    end
  end

  private

  def pop_and_parse_next_entry
    entry = read_entry

    JSON.parse(entry) if entry
  end

  def read_entry
    redis_pool.with { |conn| conn.lpop @redis_key }
  end
end
