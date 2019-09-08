class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def sign_in
    result = UserService.sign_in(params[:email], params[:password])

    if result[:token].present?
      render json: result
    else
      render json: result, status: :unauthorized
    end
  end

  def sign_up
    result = UserService.create(params[:email], params[:password], params[:password_confirmation])

    if result[:user].present?
      render json: UserService.sign_in(params[:email], params[:password])
    else
      render json: result, status: :unauthorized
    end
  end

  def sign_out
    result = UserService.sign_out(current_user)

    render json: result
  end
end
