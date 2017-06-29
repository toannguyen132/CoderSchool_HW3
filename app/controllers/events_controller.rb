class EventsController < ApplicationController
  def index
    @events = params[:search].present? ? Event.search(params[:search]).upcoming : Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
  end
end
