# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      user_data = request.env['omniauth.auth']['info']
      user = get_user_by(user_data)

      if user.save
        sign_in(user)
        flash[:notice] = t('.notice')
      else
        flash[:alert] = t('.alert')
      end

      redirect_to root_path
    end

    def logout
      session.delete('user_id')
      redirect_to root_path
    end

    private

    def sign_in(user)
      session['user_id'] = user.id
    end

    def get_user_by(user)
      user = User.find_or_initialize_by(email: user['email'])
      user.name = user['name']
      user
    end
  end
end
