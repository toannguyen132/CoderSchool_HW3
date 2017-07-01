class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @order = Order.new(event: @event)
    # @order_items = @event.ticket_types.map do |ticket_type|
    #   item = @order.order_items.build
    #   item.ticket_type = ticket_type
    #   return item
    # end
  end

  def create
    @event = Event.find(params[:event_id])
    @order = Order.new(order_params)
    if @order.order_items.any?
      @order.save
      flash[:success] = "Tickets have been purchase successfully"
      redirect_to event_path(@event)
    else 
      flash[:error] = "Ticket number should be greater than 0"
      render :new
    end
  end

  private 
  def order_params
    params.require(:order).permit(order_items_attributes: [:quantity, :ticket_type_id, :order_id])
  end
end
