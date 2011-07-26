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
    image_tag("logo.png",
              :alt => "Computer Service Center",
              :class => "round logo")
  end
  
  def settings_icon
    image_tag("settings_icon.png",
              :alt =>   "Settings",
              :class => "nav_buttons")
  end
  
  def home_icon
    image_tag("home_icon.png",
              :alt =>   "Home",
              :class => "nav_buttons")
  end
  
  def help_icon
    image_tag("help_icon.png",
              :alt =>   "Help",
              :class => "nav_buttons")
  end
  
  def profile_icon
    image_tag("profile_icon.png",
              :alt =>   "Profile",
              :class => "nav_buttons")
  end
  
  def login_icon
    image_tag("login_icon.png",
              :alt =>   "Sign in",
              :class => "nav_buttons")
  end
  
  def logout_icon
    image_tag("close_icon.png",
              :alt => "Sign out",
              :class => "nav_buttons")
  end
  
end
