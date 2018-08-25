require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module R3xxWeb
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Disable generators
    config.generators.helper = false
    config.generators.stylesheets = false
    config.generators.javascripts = false

    # Setup configurable limits
    config.link_limits = ActiveSupport::OrderedOptions.new.tap do |llims|
      llims.anonymous_session = ENV.fetch('LINK_LIMITS_ANON') { 4 }
      llims.user = ENV.fetch('LINK_LIMITS_USER') { 50 }
    end

    # Setup Redis connection pool
    config.redis_pool = ActiveSupport::OrderedOptions.new.tap do |rp|
      rp.size = ENV.fetch('WEB_CONCURRENCY') { 4 }.to_i
      rp.timeout = ENV.fetch('REDIS_TIMEOUT') { 5 }.to_i
    end

    config.redis_namespace = ENV.fetch('REDIS_NAMESPACE') { 'r3xx' }.freeze

    def redis_namespace
      config.redis_namespace
    end

    def redis_pool
      @redis_pool ||= ConnectionPool.new(config.redis_pool) do
        Redis.new(url: ENV.fetch('REDIS_URL') { 'redis://127.0.0.1:6379' })
      end
    end
  end
end
