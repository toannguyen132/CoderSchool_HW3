class EventsController < ApplicationController
  before_action :require_auth, only: [:new]

  def index
    @events = params[:search].present? ? Event.search(params[:search]).upcoming.published : Event.upcoming.published
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new(name: "Sample Name", hero_image_url: 'https://media.ticketbox.vn/eventcover/2015/12/11/C68636.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter')
    @venue = Venue.new(name: "Da Lat", full_address: "Ngoc Phat Hotel 10 Hồ Tùng Mậu Phường 3, Thành phố Đà Lạt, Lâm Đồng, Thành Phố Đà Lạt, Lâm Đồng")
    @regions = Region.all
    @categories = Category.all
    @venues = Venue.all

    # date
    @start_date = Date.tomorrow.strftime('%d/%m/%Y')
    @start_time = '00:00'
    @end_date = Date.tomorrow.strftime('%d/%m/%Y')
    @end_time = '00:00'
  end

  def edit
    @event = Event.find(params[:id])
    @venue = Venue.new(name: "Da Lat", full_address: "Ngoc Phat Hotel 10 Hồ Tùng Mậu Phường 3, Thành phố Đà Lạt, Lâm Đồng, Thành Phố Đà Lạt, Lâm Đồng")
    @regions = Region.all
    @categories = Category.all
    @venues = Venue.all

    # date
    @start_date = @event.starts_at.in_time_zone('Asia/Ho_Chi_Minh').strftime('%d/%m/%Y')
    @start_time = @event.starts_at.in_time_zone('Asia/Ho_Chi_Minh').strftime('%H:%M')
    @end_date = @event.ends_at.in_time_zone('Asia/Ho_Chi_Minh').strftime('%d/%m/%Y')
    @end_time = @event.ends_at.in_time_zone('Asia/Ho_Chi_Minh').strftime('%H:%M')
  end

  def create
    @event = Event.new(event_params)
    @venue = Venue.new(venue_params)
    @regions = Region.all
    @categories = Category.all
    @venues = Venue.all

    # date
    @start_date = params[:start_date]
    @start_time = params[:start_time]
    @end_date = params[:end_date]
    @end_time = params[:end_time]

    # assign
    #time 
    @event.starts_at = start_date_value
    @event.ends_at = end_date_value
    @event.user = current_user
    @event.venue = @venue

    # validate
    begin
      if @venue.invalid?
        raise @venue.errors.full_messages.to_sentence
      elsif @event.invalid?
        raise @event.errors.full_messages.to_sentence
      end

      # create venue
      Event.transaction do
        @venue.save

        #ticket
        params[:ticket_types].each do |k, v|
          @event.ticket_types.build(name: v[:name], price: v[:price], max_quantity: v[:max_quantity])
          # << TicketType.create(name: v[:name], price: v[:price], max_quantity: v[:max_quantity])
        end
        @event.save
      end
      redirect_to mine_events_path

    rescue Exception => e
      flash[:error] = e.message
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])

    begin
      Event.transaction do
        # byebug
        @event.assign_attributes(event_params)
        @event.assign_attributes(starts_at: start_date_value)
        @event.assign_attributes(ends_at: end_date_value)

        # venue

        # ticket
        params[:ticket_types].each do |k, v|
          ticket_params = {name: v[:name], price: v[:price], max_quantity: v[:max_quantity]}
          if @event.ticket_types[k.to_i]
            @event.ticket_types[k.to_i].assign_attributes(ticket_params)
          else 
            @event.ticket_types.build(ticket_params)
          end
        end

        # save
        @event.save

      end
      flash[:success] = "Update event successfully"
      redirect_to mine_events_path
    rescue Exception => e
      flash[:error] = e.message
      render :edit
    end
  end

  def mine
    @events = Event.posted_by(current_user.id)
  end

  def publish
    @event = Event.find(params[:event_id])
    @event.is_public = true
    if @event.save
      flash[:success] = "Event public successfully"
      redirect_to @event
    else
      flash.now[:error] = "Event public unsuccessfully"
      redirect_to :mine
    end
  end


  private
  def event_params
    params.require(:event).permit(:name, :category_id, :extended_html_description, :hero_image_url)
  end
  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id)
  end
  def ticket_types_params
    params.require(:ticket_types).permit(:name, :price, :quantity)
  end
  def start_date_value
    "#{params[:start_date]} #{params[:start_time]}".to_time
  end
  def end_date_value
    "#{params[:end_date]} #{params[:end_time]}".to_time
  end
  def get_venue_or_create
    venue = params[:venue]
  end
end
