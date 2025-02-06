module V1
  class KindsController < ApplicationController
    # Auth with JWT --> replaced by auth with devise and devise_token_auth
    # include ActionController::HttpAuthentication::Token::ControllerMethods
    # before_action :authenticate


    before_action :authenticate_user!  #  auth with devise and devise_token_auth
    before_action :set_kind, only: [ :show, :update, :destroy ]

    # GET /kinds
    def index
      @kinds = Kind.all

      render json: @kinds
    end

    # GET /kinds/1
    def show
      render json: @kind
    end

    # POST /kinds
    def create
      @kind = Kind.new(kind_params)

      if @kind.save
        render json: @kind, status: :created, location: @kind
      else
        render json: @kind.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /kinds/1
    def update
      if @kind.update(kind_params)
        render json: @kind
      else
        render json: @kind.errors, status: :unprocessable_entity
      end
    end

    # DELETE /kinds/1
    def destroy
      @kind.destroy!
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_kind
        if params[:contact_id]
          @kind = Contact.find(params[:contact_id]).kind  # Kind method invoked on Contact obj because of the belongs_to :kind association in Contact model - the kind_id in contacts is then used to find the associated Kind record.
          puts "#Kind id1: #{@kind.inspect} and type: #{@kind.class}"
          return @kind
          # kind_id = Contact.find(params[:contact_id]).kind.id
          # puts "#Kind id1: #{kind_id.inspect} and type: #{kind_id.class}"
          # return @kind = Kind.find(kind_id)
        end

        @kind = Kind.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def kind_params
        params.expect(kind: [ :description ])
      end

    # Auth with JWT --> replaced by auth with devise and devise_token_auth
    # def authenticate
    #   # authenticate_or_request_with_http - can take the token in front of Bearer (auth header)
    #   authenticate_or_request_with_http_token do |token, options|
    #     # to mitigate timing-attacks
    #     # ActiveSupport::SecurityUtils.secure_compare(
    #     #   ::Digest::SHA256.hexdigest(token),
    #     #   ::Digest::SHA256.hexdigest(TOKEN)
    #     # )
    #     hmac_secret = "my$ecretK3y"
    #     JWT.decode(token, hmac_secret, true, { algorithm: "HS256" })
    #   end
    # end
  end
end
