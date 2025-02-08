class Contact < ApplicationRecord
  validates_presence_of :kind
  # validates_presence_of :address

  belongs_to :kind# , optional: true
  has_many :phones
  # access phones of a contact: ex.: Contact.first.phones
  has_one :address # can add different addresses, but will save the last one (wuth dif. address id)
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def author
    "fg"
  end
  def kind_description
    self.kind.description
  end
  # redefining the as_json (to apply changes to all actions - formatting)
end
# class Contact < ApplicationRecord
#   belongs_to :kind
#   def author
#     "fg"
#   end
#   def kind_description
#     self.kind.description
#   end
#   # redefining the as_json (to apply changes to all actions - formatting)
#   def as_json(options = {})
#     super(
#       root: true,
#       methods: [ :kind_description, :author,  ], # methods in as_json expects array of methods as symbols
#         # include: :kind, #get the association declared in belongs_to :kind in the Contact model
#         # include: {
#         #   kind: {
#         #     only: :description
#         #     }
#         #   }
#       )
#   end
# end
