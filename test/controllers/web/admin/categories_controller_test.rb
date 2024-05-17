# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @admin = users(:admin)
        @category = categories(:one)
      end

      test 'should get index' do
        sign_in @admin
        get admin_categories_url
        assert_response :success
      end

      test 'should get new' do
        sign_in @admin
        get new_admin_category_url
        assert_response :success
      end

      test 'should create category' do
        sign_in @admin

        name = Faker::Lorem.sentence(word_count: 2)
        post admin_categories_url,
             params: { category: {
               name:
             } }

        assert Category.find_by(name:)
      end

      test 'should get edit' do
        sign_in @admin
        get edit_admin_category_url(@category)
        assert_response :success
      end

      test 'should update category' do
        sign_in @admin

        name = Faker::Lorem.sentence(word_count: 2)
        patch admin_category_url(@category),
              params: { category: { name: } }
        assert Category.find_by(name:)
      end
    end
  end
end
