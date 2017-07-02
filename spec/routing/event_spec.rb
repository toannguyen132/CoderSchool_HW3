require 'rails_helper'


RSpec.describe "route for events", :type => :routing do

  # context "confirm_subscription route" do

    it "should render index for upcoming events" do
      expect(:get => upcoming_path).to route_to('events#index')
    end

    it "should render mine " do
      expect(:get => mine_events_path).to route_to('events#mine')
    end

  # end

end