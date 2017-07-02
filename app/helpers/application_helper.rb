module ApplicationHelper

  def flash_class(type)
    {success: 'alert-success', error: 'alert-danger'}[type.to_sym]
  end

  def flash_message
    flash.map do |msg_type, message|
      content_tag('div', class: "alert alert-global #{flash_class(msg_type)}") do
        content_tag('button', '<i class="fa fa-remove"></i>'.html_safe, {class: 'close', 'data-dismiss': 'alert'} ) + message
      end
    end.join.html_safe
  end

  def time_options
    hours = (0..23).to_a
    minutes = [00, 30]
    options = []
    hours.each do |h| 
      minutes.each do |m| 
        options.push(h.to_s.rjust(2, "0") + ':' + m.to_s.rjust(2, "0"))
      end
    end

    options
  end
end
