require 'test_helper'

class Users::RegistrationsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user_params = { user: { email: 'alice@r3xx.io', password: 'cantseeme' } }
  end

  test 'after successful sign up with links in session' do
    assert_difference 'User.count' do
      post :create, params: @user_params, session: {
        link_idents: [links(:anon_rand_1), links(:anon_rand_2)].map(&:ident)
      }
    end

    assert_equal User.last, links(:anon_rand_1).reload.user
    assert_equal User.last, links(:anon_rand_2).reload.user
  end
end
