# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :check_admin
    end
  end
end
