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

  describe ".upcoming" do
    before do
      @event = Event.create(starts_at: 10.days.from_now)
      
      @event.save(validate: false)
    end

    it "Display all comming events" do
      events = Event.upcoming

      expect(events).to eq [@event]
    end

    it "Don't display past event" do
      past_event = Event.create(starts_at: 10.days.ago)
      events = Event.upcoming

      expect(events).to eq [@event]
    end
  end

  describe ".search" do
    before do
      @event_a = Event.new(name: "event a")
      @event_a.save(validate: false)
      @event_b = Event.new(name: "event b")
      @event_a.save(validate: false)
    end

    it "return related event when searching" do
      searched_events = Event.search("event a")

      expect(searched_events).to eq([@event_a])
    end
  end

  describe "#have_enough_ticket_types?" do
    before do
      @event = Event.new
    end

    it "return false if there is no ticket event" do
      expect(@event.have_enough_ticket_types?).to eq false
    end

    it "return false if all tickets have 0 max quantity" do
      @event.ticket_types.build(max_quantity: 0) 
      expect(@event.have_enough_ticket_types?).to eq false
    end

    it "return true if there is no ticket event" do
      @event.ticket_types.build(max_quantity: 10)
      expect(@event.have_enough_ticket_types?).to eq true
    end
  end

end
