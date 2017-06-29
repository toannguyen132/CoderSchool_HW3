require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "GET #index" do
    subject { get :index }
    it "homepage should render index template" do
      expect(subject).to render_template(:index)
    end

    # it "homepage should render " do
    #   get :index, params: {s: 'event'}
    #   expect(subject).to render_template(:index)
    # end    
  end

end
