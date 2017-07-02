require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe "time options" do
    it "get correctly time options type" do
      expect(helper.time_options).to be_instance_of(Array)
    end
    it "get correctly time options length" do
      expect(helper.time_options.count).to eq(48)
    end
  end

  describe "flash message" do 
    it "display success message" do 
      flash.now[:success] = "sample message"
      expect(helper.flash_message).to include("sample message")
      expect(helper.flash_message).to include("alert-success")
    end
  end
end
