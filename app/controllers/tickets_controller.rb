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
    Order.transaction do 
      @order = Order.create!()
      count = 0
      order_params[:order_items_attributes].each do |k, v|
        next if v['quantity'] == 0
        order_item = OrderItem.new(v)
        order_item.order = @order
        if order_item.save!
          count+=1
        else
          raise ActiveRecord::Rollback, "There is error while purchasing ticket"
        end
      end
      if count == 0 
        raise ActiveRecord::Rollback, "No ticket has been purchase!"
      else 
        @order.save!
    end
    flash[:success] = "Tickets have been purchase successfully"
    redirect event_path(@event)

    rescue Exception => ex
      byebug
      flash[:error] = ex
      render :new
    end
  end

  private 
  def order_params
    params.require(:order).permit(order_items_attributes: [:quantity, :ticket_type_id])
  end
end
