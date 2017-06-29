require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe "validate" do 
    it "cannot create the venues with the same name" do 
      venue1 = Venue.new(name: 'name').save
      venue2 = Venue.new(name: 'name')
      venue2.validate

      expect(venue2.errors[:name]).to eq ["has already been taken"]
      # expect(@event.errors[:venue]).to eq ["can't be blank"]
    end
  end
end
