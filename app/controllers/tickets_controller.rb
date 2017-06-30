class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
    @order_items = @event.ticket_types.map do |ticket_type|
      item = @order.order_items.build
      item.ticket_type = ticket_type
      return item
    end
  end

  def create
    @event = Event.find(params[:event_id])
    byebug
    @order = Order.create()
    @order.save
    order_params[:order_items_attributes].each do |k, v|
      order_item = OrderItem.new(v)
      order_item.order = @order
      order_item.save
      puts @order.id
    end

    render :new
  end

  private 
  def order_params
    params.require(:order).permit(order_items_attributes: [:quantity, :ticket_type_id])
  end
end
