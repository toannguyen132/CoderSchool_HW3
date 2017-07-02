require 'rails_helper'

RSpec.describe "route for session", :type => :routing do

  # context "confirm_subscription route" do

    it "should route to new for login" do
      expect(:get => login_path).to route_to('sessions#new')
    end

    it "should not able to render logout path " do
      expect(:get => logout_path).not_to be_routable
    end

    it "should route to destroy for logout path " do
      expect(:delete => logout_path).to route_to('sessions#destroy')
    end    

  # end

end