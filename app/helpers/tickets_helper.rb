module TicketsHelper
  def ticket_index_row(ticket)
    ["#{ticket.customer.fname} #{ticket.customer.lname}",
    "#{ticket.computer.make} #{ticket.computer.model}", truncate(ticket.issue, :length => 20),
    (ticket.technician) ? "#{ticket.technician.fname.first}#{ticket.technician.lname.first}" : "--",
    (ticket.status.nil?) ? "None" : ticket.status,
    "#{time_ago_in_words(ticket.created_at)} ago"]
  end
end
