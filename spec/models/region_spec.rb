require 'rails_helper'

RSpec.describe Region, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    ['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong'].each do |r|
      Region.create(name: r)
    end
  end

  it "return region name correctly" do
    names = Region.all.map{ |region| region.name }

    expect(names).to match_array ['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong']
  end

end
