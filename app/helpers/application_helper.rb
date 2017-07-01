module ApplicationHelper

  def flash_class(type)
    {success: 'alert-success', error: 'alert-danger'}[type.to_sym]
  end

  def flash_message
    flash.map do |msg_type, message|
      content_tag('div', class: "alert #{flash_class(type)}") do
        content_tag('button', 'x'.htmk_safe, class: 'close') + message
      end
    end.join.html_safe
  end
end
