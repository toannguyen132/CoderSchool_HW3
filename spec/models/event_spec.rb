require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  # validates_presence_of :extended_html_description, :venue, :category, :starts_at
  # validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  describe "validate presence" do
    before do
      @event = Event.new()
      @event.validate
    end

    it "Cannot create event without extended_html_description" do
      expect(@event.errors[:extended_html_description]).to eq ["can't be blank"]
    end
    it "Cannot create event without venue" do
      expect(@event.errors[:venue]).to eq ["can't be blank"]
    end
    it "Cannot create event without category" do
      expect(@event.errors[:category]).to eq ["can't be blank"]
    end
    it "Cannot create event without starts_at" do
      expect(@event.errors[:starts_at]).to eq ["can't be blank"]
    end
  end

  it "Cannot create two event with the same name" do
    eventA = Event.new(name: "event name")
    eventA.save(:validate => false)

    eventB = Event.new(name: "event name")
    eventB.validate

    expect(eventB.errors[:name]).to eq ["has already been taken"]
  end

  describe ".comming_event" do
    before do
      @event = Event.create(starts_at: 10.days.from_now)
      
      @event.save(validate: false)
    end

    it "Display all comming events" do
      events = Event.comming_events

      expect(events).to eq [@event]
    end

    it "Don't display past event" do
      past_event = Event.create(starts_at: 10.days.ago)
      events = Event.comming_events

      expect(events).to eq [@event]
    end
  end

end
