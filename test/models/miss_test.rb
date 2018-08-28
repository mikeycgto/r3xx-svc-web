require 'test_helper'

class MissTest < ActiveSupport::TestCase
  setup do
    @model_class = Miss
  end

  include DeviceDetectableTest
  include LocationableTest
end
