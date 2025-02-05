class ApplicationController < ActionController::API
        before_action :configure_permitted_parameters, if: :devise_controller?
        include DeviseTokenAuth::Concerns::SetUserByToken
  # before_action :ensure_json_request

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :nickname, :image ])
  end

  def ensure_json_request
    return if request.headers["Accept"] =~ /json/ # check in Header, if Accept contains smt with json, and continue if true.
    head 406 # otherwise respond with status "not acceptable"
  end
end
