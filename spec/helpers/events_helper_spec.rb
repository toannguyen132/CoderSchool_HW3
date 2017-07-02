require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EventsHelper. For example:
#
# describe EventsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EventsHelper, type: :helper do
  describe "#background" do
    it "get header_background_image_url" do
      expect(helper.header_background_image_url).to include('color-me-run')
    end
  end
end
