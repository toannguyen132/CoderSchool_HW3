require 'rails_helper'

RSpec.describe "sessions/new.html.erb", type: :view do

  it "Display Title" do
    render

    rendered.should include("Login")
  end

  it "Display Login Field" do
    render

    rendered.should have_selector("input[name=email]")
  end

  it "Display Password Field" do
    render

    rendered.should have_selector("input[name=password][type=password]")
  end

  it "Display Button Login" do
    render

    rendered.should have_selector("form .btn.btn-primary")
  end

end
