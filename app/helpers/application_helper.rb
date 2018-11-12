module ApplicationHelper

  def full_title(title)
    title_trail = "kairoi"
    if title.empty?
      title_trail
    else
      title + " | " + title_trail
    end
  end

  # Converts devise alert types to bootstrap types
  def convert_to_bootstrap_alert(type)
    case type
    when 'alert' then 'danger'
    when 'notice' then 'success'
    else type
    end
  end
end
