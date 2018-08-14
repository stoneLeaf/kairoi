module ApplicationHelper

  def full_title(title)
    title_trail = "kairoi"
    if title.empty?
      title_trail
    else
      title + " | " + title_trail
    end
  end

end
