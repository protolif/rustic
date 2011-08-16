module ApplicationHelper
  
  def title
    base_title = 'Computer Service Center'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def business_address
    "8403-B North Michigan Road, Indianapolis, IN 46268"
  end
  
  # begin google stuff
  def google_api_key
    "ABQIAAAAZRC0gmdLmBX9V0YwrHTlOBQX18q_N83UXD1WuWYGeHyoxvyv8hRpwow87gLX842REO5mjCiernbzng"# Registered to cscindy.com. Get your own.
  end
  
  def google_maps_img
    image_tag("http://maps.google.com/staticmap?center=39.90845,-86.22116&zoom=15&size=400x325&maptype=mobile&markers=39.90845,-86.22116,red&key=#{google_api_key}&sensor=false",
              :alt => "Our location on Google Maps",
              :class => "google_map")
  end
  
  def directions_url
    "http://maps.google.com/maps?daddr=8403+N+Michigan+Rd,+Indianapolis,+IN+46268&hl=en&sll=39.666759,-86.130215&sspn=0.008407,0.01929&mra=ls&t=h&z=16"
  end
  
  def directions_to
    link_to(google_maps_img, directions_url, :target => "_blank")
  end
  
  # begin images
  
  def logo
    image_tag("logo.png",
              :alt => "Computer Service Center",
              :class => "round logo")
  end
  
  def settings_icon
    image_tag("settings_icon.png",
              :alt   => "Settings",
              :title => "Settings",
              :class => "nav_buttons")
  end
  
  def home_icon
    image_tag("home_icon.png",
              :alt =>   "Home",
              :title => "Home",
              :class => "nav_buttons")
  end
  
  def help_icon
    image_tag("help_icon.png",
              :alt =>   "Help",
              :title => "Help",
              :class => "nav_buttons")
  end
  
  def profile_icon
    image_tag("profile_icon.png",
              :alt   => "My Profile",
              :title => "My Profile",
              :class => "nav_buttons")
  end
  
  def users_index_icon
    image_tag("users_index_icon.png",
              :alt   => "All Users",
              :title => "All Users",
              :class => "nav_buttons")
  end
  
  def login_icon
    image_tag("login_icon.png",
              :alt   => "Sign In",
              :title => "Sign In",
              :class => "nav_buttons")
  end
  
  def logout_icon
    image_tag("close_icon.png",
              :alt   => "Sign Out",
              :title => "Sign Out",
              :class => "nav_buttons")
  end
  
  def edit_icon
    image_tag("write.png",
              :alt   => "Edit This Computer",
              :title => "Edit This Computer",
              :class => "edit_button")
  end
  
  def ticket_icon
    image_tag("ticket_icon.png",
              :alt   => "Create a Ticket",
              :title => "Create a Ticket",
              :class => "ticket_button")
  end
  
  def chpwd_icon
    image_tag("chpwd_icon.png",
              :alt   => "Change Password",
              :title => "Change Password",
              :class => "chpwd_button")
  end
  
  def charger_icon
    image_tag("charger_icon.png",
              :alt   => "With Charger",
              :title => "With Charger",
              :class => "charger_icon")
  end
end
