module V1
  class ContactSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :birthdate, :author

    belongs_to :kind do
      link(:related) { v1_contact_kind_url(object.id) }
    end

    has_many :phones do
      link(:related) { v1_contact_phones_url(object.id) }
    end

    has_one :address do
      link(:related) { v1_contact_address_url(object.id) }
    end

    # add HATEOAS
    # link(:self) { contact_url(object.id) }
    # link(:kind) { kind_url(object.kind.id) } # - link added inside the relationships

    meta do
      { author: "fg" }
    end

    def attributes(*arg) # splat operator
      h = super(*arg) # call parent ActiveModel::Serializer's attributes method - returns hash of the model's attributes

      # Rails.logger.debug("Returned from super: #{h.inspect}")
      # Ex.: Returned from super: {:id=>77, :name=>"Shena Hilpert", :email=>"rosita@oconnell-runolfsson.test", :birthdate=>"1962-06-05"}

      h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
      h
    end
  end
end
