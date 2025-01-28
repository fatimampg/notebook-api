class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :author

  belongs_to :kind do
    link(:related) { kind_url(object.kind.id) }
  end
  has_many :phones
  has_one :address

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
