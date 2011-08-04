module ComputersHelper

  # begin driver links
  
  def dell_drivers_link(svc_tag)
    base_link = "http://support.dell.com/support/downloads/index.aspx?c=us&cs=555&l=en&s=biz&ServiceTag="
    link_to("Drivers", base_link + svc_tag, :target => "_blank")
  end
  
  def hp_drivers_link(model)
    base_link = "http://h10025.www1.hp.com/ewfrf/wc/pfinder?cc=us&dlc=en&lc=en&tool=&query="
    link_to("Drivers", base_link + model, :target => "_blank")
  end
end
