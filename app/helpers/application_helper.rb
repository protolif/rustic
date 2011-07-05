module ApplicationHelper
  
  def title
    base_title = 'Computer Service Center'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "Computer Service Center", :class => "round")
  end
end
