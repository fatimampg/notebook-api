class ApplicationController < ActionController::API
  before_action :ensure_json_request
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :nickname, :image ])
  end

  # JSON:API specifications
  def ensure_json_request
    unless request.headers["Accept"] =~ /json/ # if Accept header does not contains json, reject with error 406 - Not Acceptable
      render nothing: true, status: 406
    else
      unless request.get? # if request is not type GET, check if Content-Type header contains json. Reject with error 415 - Unsupported media type, if it Content-Type does not contains json.
        return if request.headers["Content-Type"] =~/json/
        render nothing: true, status: 415
      end
    end
  end
end
