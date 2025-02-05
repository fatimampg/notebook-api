class AuthsController < ApplicationController
  # using just jwt:
  def create
    hmac_secret = "my$ecretK3y"
    puts params.keys
    exp = Time.now.to_i + 30
    payload = { name: params[:name], exp: exp }
    puts "Payload:{ name: params[:name]} --> #{payload}"
    # params (indifferent access (HashWithIndifferentAccess))
    token = JWT.encode(payload, hmac_secret, "HS256")
    render json: { token: token }
  end
end
