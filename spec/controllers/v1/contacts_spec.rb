require "rails_helper"

describe V1::ContactsController, type: :controller do
  describe "GET #index - GET v1/contacts/" do
    it "should return status code 200 OK, when header accept json is provided" do
      request.accept = "application/vnd.api+json"
      get :index
      # expect(response.status).to eql(200)
      expect(response).to have_http_status(200)
    end

    it "should return status code 406 Not Acceptable, when header accept json is not provided" do
      get :index
      expect(response).to have_http_status(406)
    end
  end

  describe "GET #show - GET v1/contacts/:id" do
    it "should return correct contact data" do
      contact = Contact.first
      request.accept = "application/vnd.api+json"
      get :show, params: { id: contact.id }
      response_body = JSON.parse(response.body) # returns a hash (contact info nested in "data")
      expect(response_body.fetch("data").fetch("id")).to eq(contact.id.to_s)
      expect(response_body.fetch("data").fetch("type")).to eq("contacts")
    end
  end
end
