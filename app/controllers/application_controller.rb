class ApplicationController < ActionController::API
  before_action :authenticate_request

  expose(:current_user) { UserService.authenticate(request.headers)[:user] }

  def authenticate_request
    render json: { error: 'Not Authorized' }, status: 401 unless current_user
  end
end
