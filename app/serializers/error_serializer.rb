module ErrorSerializer
  def self.serialize(errors)
    return if errors.nil?
    json = {}
    new_hash = errors.to_hash.map do |key, value|
      value.map do |msg| # 1 key (which represents a field (ex.: kind)) can have more than 1 value (value is an array of error messages)
        { id: key, title: msg } # accoording to JSON:API error response structure
      end # results nested arrays
    end.flatten
    json[:errors] = new_hash
    json
  end
end

# ex.: received error (@contact.error):
# {
#     "kind": [
#         "can't be blank",
#         "must exist"
#     ],
#     "address": [
#         "can't be blank"
#     ]
# }
#
# Expected format (JSON:API):
#     "errors": [
#         {
#             "id": "kind",
#             "title": "can't be blank"
#         },
#         {
#             "id": "kind",
#             "title": "must exist"
#         },
#         {
#             "id": "address",
#             "title": "can't be blank"
#         }
#     ]
# }
