class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, except: :sign_out

  def sign_in
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def sign_up
    command = CreateUser.call(params[:email], params[:password], params[:password_confirmation])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def sign_out
    command = SignOutUser.call(current_user)

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
