class ApplicationController < ActionController::API
  before_action :authenticate_request

  expose(:current_user) { AuthorizeApiRequest.call(request.headers).result }

  def authenticate_request
    render json: { error: 'Not Authorized' }, status: 401 unless current_user
  end
end
