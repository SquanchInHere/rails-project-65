# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
    end

    test 'should get show' do
      sign_in @user
      get profile_url
      assert_response :success
    end

    test 'should not get show' do
      get profile_url

      assert_redirected_to root_path
    end
  end
end
