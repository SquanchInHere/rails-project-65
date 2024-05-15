class Web::AuthController < ApplicationController
  def callback
    user_info = request.env['omniauth.auth']['info']
    user = get_user_by(user_info)

    if user.save
      sign_in(user)
      flash[:notice] = t('.notice')
    else
      flash[:alert] = t('.alert')
    end

    redirect_to root_path
  end

  private

  def sign_in(user)
    session['user_id'] = user.id
  end

  def get_user_by(user_info)
    user = User.find_or_initialize_by(email: user_info['email'])
    user.name = user_info['name']
    user
  end
end
