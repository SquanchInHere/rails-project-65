# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @user = users(:one)
        @bulletin = bulletins(:one)
        @bulletin_under_moderation = bulletins(:under_moderation)
      end

      test 'should get index' do
        sign_in @admin
        get admin_root_url
        assert_response :success
      end

      test 'shold get under_moderation bulletins' do
        sign_in @admin
        get admin_bulletins_url
        assert_response :success
      end

      test 'should publish bulletin' do
        sign_in @admin
        attach_file_to(@bulletin_under_moderation)

        patch publish_admin_bulletin_url(@bulletin_under_moderation)
        assert_equal Bulletin.find(@bulletin_under_moderation.id).state, 'published'
      end

      test 'should not publish bulletin' do
        attach_file_to(@bulletin_under_moderation)
        patch publish_admin_bulletin_url(@bulletin_under_moderation)

        assert_redirected_to root_path
      end

      test 'should reject bulletin' do
        sign_in @admin
        attach_file_to(@bulletin_under_moderation)
        patch reject_admin_bulletin_url(@bulletin_under_moderation)
        assert_equal Bulletin.find(@bulletin_under_moderation.id).state, 'rejected'
      end

      test 'should not reject bulletin' do
        attach_file_to(@bulletin_under_moderation)
        patch reject_admin_bulletin_url(@bulletin_under_moderation)

        assert_redirected_to root_path
      end

      test 'should archive bulletin' do
        sign_in @admin
        attach_file_to(@bulletin)
        patch archive_admin_bulletin_url(@bulletin)
        assert_equal Bulletin.find(@bulletin.id).state, 'archived'
      end

      test 'should not archive bulletin' do
        attach_file_to(@bulletin)
        patch archive_admin_bulletin_url(@bulletin)

        assert_redirected_to root_path
      end

      def attach_file_to(bulletin)
        bulletin.image.attach(io: Rails.root.join('test/fixtures/files/first.jpg').open, filename: 'filename.jpg')
      end
    end
  end
end
