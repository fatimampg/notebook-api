module V2
  class PhonesController < ApplicationController
    before_action :set_contact

    # DELETE /contacts/1/phones
    def destroy
      phone = Phone.find(phone_params[:id])
      phone.destroy
    end

    # POST /contacts/1/phone
    def create
      @contact.phones << Phone.new(phone_params)
      if @contact.save
        render json: @contact.phones, status: :created, location: contact_phones_url(@contact) # location - inform location through the header
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH /contacts/1/phone
    def update
      puts "received phone_params ---> #{phone_params}"
      # phone_params ---> {:number=>"592 695 134511111", :id=>"3"} (received the phone id)
      phone = Phone.find(phone_params[:id])

      if phone.update(phone_params)
        render json: @contact.phones
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
    # GET /contacts/1/phones
    def show
      render json: @contact.phones
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
          @contact = Contact.find(params[:contact_id])
      end
      def phone_params
          ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end
