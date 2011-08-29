module UsersHelper
  
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => "#{user.fname} #{user.lname}",
                                            :class => "gravatar",
                                            :gravatar => options)
  end
  
  def inline_superscript(text, symbol)
    content_tag(:span, text) + content_tag(:span, symbol, :class => 'caveat')
  end
  
  def noob?
    @user.new_record?
  end
  
  def noob_text(a, b)
    (noob?) ? a : b
  end
  
  def changing_password?
    params[:chpwd] == "1"
  end
  
  def need_password?
    noob? || changing_password?
  end
  
  def new_ticket_link(computer)
    link_to(ticket_icon, new_ticket_path + "?user_id=#{@user.id}&computer_id=#{computer.id}")
  end
  
  def edit_link(computer)
    link_to(edit_icon, edit_computer_path(computer) + "?user_id=#{@user.id}")
  end
  
  def delete_link(computer)
    link_to(content_tag(:span, "-", :class => "subtract round"),
            computer_path(computer) + "?user_id=#{@user.id}",
            :method => :delete,
            :confirm => "You sure?",
            :title => "Delete This Computer")
  end
  
  def computer_row(computer)
    [computer.make, computer.model, truncate(computer.serial, :length => 10),
    checked_in_at(computer), checked_out_at(computer),
    new_ticket_link(computer) + edit_link(computer) + delete_link(computer)]
  end
  
  def ticket_row(ticket)
    [ticket.computer.make, ticket.computer.model, truncate(ticket.issue),
    (ticket.technician) ? ticket.technician.fname : "None",
    (ticket.status.nil?) ? "None" : ticket.status,
    "#{time_ago_in_words(ticket.created_at)} ago"]
  end
end
