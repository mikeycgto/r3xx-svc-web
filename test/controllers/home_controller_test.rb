require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'GET index' do
    get root_url

    assert_response :success
  end
end
