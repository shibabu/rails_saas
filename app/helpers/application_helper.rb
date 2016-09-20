module ApplicationHelper

  def bootstrap_alert_class type
    case type
      when 'notice'
        'alert-success' #Green
      when 'alert'
        'alert-danger' #Red
      else
        type.to_s
    end
  end

end
