require 'auth_token'

class AuthController < ApplicationController
  def authenticate
    # You'll need to implement the below method. It should return the
    # user instance if the username and password are valid.
    # Otherwise return nil.
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: authentication_payload(user)
    else
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end
  end

  private

  def authentication_payload(user)
    return nil unless user && user.id
    {
      auth_token: AuthToken.encode({ user_id: user.id }),
      user: { id: user.id, username: user.username } # return whatever user info you need
    }
  end
end
