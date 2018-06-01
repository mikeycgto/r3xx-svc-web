require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  module TestCases
    extend ActiveSupport::Concern

    included do
      setup do
        @create_params = { link: { url: 'http://foo.com' } }
        @update_params = { link: { url: 'http://new.com' } }
      end

      test 'GET new' do
        get new_link_path

        assert_response :success
      end

      test 'POST create' do
        assert_difference 'Link.count' do
          post links_path, params: @create_params
        end

        refute_nil flash[:notice]
        assert_redirected_to links_url
      end

      test 'GET edit' do
        get edit_link_path(edit_link)

        assert_response :success
      end

      test 'GET edit without access' do
        get edit_link_path(links(:anon_rand_1))

        assert_redirected_to links_url
        refute_nil flash[:alert]
      end

      test 'GET edit not found' do
        get edit_link_path(0)

        assert_redirected_to links_url
        refute_nil flash[:alert]
      end

      test 'PATCH update' do
        patch link_path(edit_link), params: @update_params

        assert_redirected_to links_url
        refute_nil flash[:notice]
        assert_equal @update_params[:link][:url], edit_link.reload.url
      end

      test 'PATCH update without access' do
        patch link_path(links(:anon_rand_1)), params: @update_params

        assert_redirected_to links_url
        refute_nil flash[:alert]
        refute_equal @update_params[:link][:url], links(:anon_rand_1).reload.url
      end

      test 'PATCH update not found' do
        patch link_path(0), params: @update_params

        assert_redirected_to links_url
        refute_nil flash[:alert]
      end

      test 'DELETE destroy' do
        delete link_path(edit_link)

        assert_redirected_to links_url
        refute_nil flash[:notice]

        assert_raises ActiveRecord::RecordNotFound do
          edit_link.reload
        end
      end

      test 'DELETE destroy without access' do
        delete link_path(links(:anon_rand_1)), params: @update_params

        assert_redirected_to links_url
        refute_nil flash[:alert]
        refute_equal @update_params[:link][:url], links(:anon_rand_1).reload.url
      end

      test 'DELETE destroy not found' do
        delete link_path(0)

        assert_redirected_to links_url
        refute_nil flash[:alert]
      end
    end
  end

  class WithUser < ActionDispatch::IntegrationTest
    def edit_link
      links(:bob_foo)
    end

    setup do
      @user = users(:bob)

      login_as @user, scope: :user
    end

    test 'POST create associates user' do
      assert_difference 'users(:bob).links.count' do
        post links_path, params: @create_params
      end
    end

    test 'DELETE removes from user links' do
      assert_difference 'users(:bob).links.count', -1 do
        delete link_path(edit_link)
      end
    end

    include TestCases
  end

  class WithSession < ActionDispatch::IntegrationTest
    def edit_link
      @edit_link ||= create_link
    end

    include TestCases

    test 'POST adds to session' do
      post links_path, params: @create_params

      assert_includes session[:link_idents], Link.last.ident
    end

    private

    def create_link
      post links_path, params: @create_params

      Link.last
    end
  end
end
