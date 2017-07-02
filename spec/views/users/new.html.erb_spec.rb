require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :view do
  
  before do
    @user = User.new(name: Faker::Name.name, email: Faker::Internet.email)
    render
  end

  it "Display Title" do
    rendered.should include("Sign up")
  end

  it "Display Required fields" do
    rendered.should have_selector("input[name='user[name]']")
    rendered.should have_selector("input[name='user[email]']")
    rendered.should have_selector("input[name='user[password]'][type=password]")
    rendered.should have_selector("input[name='user[password_confirmation]'][type=password]")
    rendered.should have_selector("form .btn.btn-primary")
  end

end
