class EventsController < ApplicationController
  def index
    @events = Event.comming_events
  end

  def show
    @event = Event.find(params[:id])
  end
end
