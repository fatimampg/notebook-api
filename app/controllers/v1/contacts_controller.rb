module V1
  class ContactsController < ApplicationController
    include ErrorSerializer

    before_action :set_contact, only: %i[ show update destroy ]

    # GET /contacts
    def index
      @contacts = Contact.all

      expires_in 30.seconds, public: true
      # status: 304 - Not modified (when requested within that period) (if content doesnt change (via ETag or Last-Modified headers), may return 304 even after the expiration period due to rails' internal cache mechanism)
      if stale?(etag: @contacts)
        render json: @contacts
      end
      # if stale?(last_modified: @contacts[0].updated_at)
      #   render json: @contacts
      # end
      # render json: @contacts, status: :ok, root: false, only: [ :email, :name ]
      # no need to directly call to_json (Rails does it under the hood)
      # root: true --> add root element (in this case, contact) (the data for each contact will be nested inside that root)
      #
      # render json: @contacts.map { |contact| contact.attributes.merge({ author: "fg" }) }
      # render json: @contacts, methods: :author
    end

    # GET /contacts/1
    def show
      render json: @contact, include: [ :kind, :address, :phones ]# , meta: { author: "fg" }
      # render json: @contact.attributes.merge({ author: "fg" })
      # render json: { name: @contact.name, email: @contact.email }
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [ :kind, :phones, :address ], status: :created, location: @contact
      else
        render json: ErrorSerializer.serialize(@contact.errors)
        # render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [ :kind, :phones, :address ]
      else
        render json: ErrorSerializer.serialize(@contact.errors)
        # render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy!
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def contact_params
        # params.require(:contact).permit(
        #   :name, :email, :birthdate, :kind_id,
        #   phones_attributes: [ :id, :number, :_destroy ],
        #   address_attributes: [ :id, :street, :city ])
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end
