require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create, { email: "", password: "" }
      expect(response).to render_template :new #have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns not to routable" do
      # get :destroy
      expect(get: 'destroy').not_to be_routable #have_http_status(:success)
    end
  end

end
