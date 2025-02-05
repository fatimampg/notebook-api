class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :ensure_json_request

  def ensure_json_request
    return if request.headers["Accept"] =~ /json/ # check in Header, if Accept contains smt with json, and continue if true.
    head 406 # otherwise respond with status "not acceptable"
  end
end
