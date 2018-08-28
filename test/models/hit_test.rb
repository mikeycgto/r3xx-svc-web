require 'test_helper'

class HitTest < ActiveSupport::TestCase
  setup do
    @model_class = Hit
  end

  include DeviceDetectableTest
  include LocationableTest
end
