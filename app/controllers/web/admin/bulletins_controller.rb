# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      before_action :set_bulletin, only: %i[publish reject archive]
      after_action :verify_authorized, only: %i[publish reject archive]

      def index
        @q = Bulletin.send(params[:filter]).includes(:user).ransack(params[:q])
        @bulletins = @q.result
                       .default_order
                       .page(params[:page])
      end

      def publish
        authorize @bulletin
        if @bulletin.may_publish?
          @bulletin.publish!
          flash[:notice] = t('.notice')
        else
          flash[:alert] = t('.alert')
        end
        redirect_to admin_root_path
      end

      def reject
        authorize @bulletin
        if @bulletin.may_reject?
          @bulletin.reject!
          flash[:notice] = t('.notice')
        else
          flash[:alert] = t('.alert')
        end
        redirect_to admin_root_path
      end

      def archive
        authorize @bulletin
        if @bulletin.may_archive?
          @bulletin.archive!
          flash[:notice] = t('.notice')
        else
          flash[:alert] = t('.alert')
        end
        redirect_to admin_root_path
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
