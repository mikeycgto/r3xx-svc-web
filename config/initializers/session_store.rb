# Use cookie based sessions with a 16 day expiration
Rails.application.config.session_store :cookie_store, key: '_r3xx_io', expires_after: 16.days
