# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[edit update destroy]

      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def edit; end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('.notice')
        else
          flash[:alert] = t('.alert')
          render :new, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('.notice')
        else
          flash[:alert] = t('.alert')
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.bulletins.any?
          flash[:alert] = t('.alert')
        else
          @category.destroy!
          flash[:notice] = t('.notice')
        end
        redirect_to admin_categories_url
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
