require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test 'url invalid when blank' do
    link = Link.new.tap(&:valid?)

    assert_includes link.errors, :url
  end

  test 'url invalid when non-http protocol' do
    link = Link.new(url: 'mailto:bob@r3xx.io').tap(&:valid?)

    assert_includes link.errors, :url
  end

  test 'url invalid' do
    link = Link.new(url: 'foo').tap(&:valid?)

    assert_includes link.errors, :url
  end

  test 'valid http url' do
    link = Link.new(url: 'http://r3xx.io').tap(&:valid?)

    refute_includes link.errors, :url
  end

  test 'valid https url' do
    link = Link.new(url: 'https://r3xx.io').tap(&:valid?)

    refute_includes link.errors, :url
  end

  test 'valid url without protocol' do
    link = Link.new(url: 'rx33.io').tap(&:valid?)

    refute_includes link.errors, :url
  end

  test 'after commit sets on redis' do
    link = Link.create(url: 'r3xx.io')

    Rails.application.redis_pool.with do |conn|
      assert_equal 'r3xx.io', conn.get(link.redis_key)
    end
  end

  test 'after destroy dels on redis' do
    link = Link.create(url: 'r3xx.io').tap(&:destroy)

    Rails.application.redis_pool.with do |conn|
      assert_nil conn.get(link.redis_key)
    end
  end
end
