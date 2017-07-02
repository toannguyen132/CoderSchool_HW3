require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, { user: { name: "test", email: 'toan@gmail.comn', 'password': '123', 'password_confirmation': '123'} }
      expect(response).to redirect_to(controller: :sessions, action: :new)
    end

    it "Display errors if create user failed" do
      post :create, { user: { name: "test", email: 'toan@gmail.comn', 'password': '123', 'password_confirmation': '123123'} }
      expect(response).to render_template(:new)
    end
  end


end
