class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :status_404

def status_404
  render json: { error: {} }, status: 404
end
end
