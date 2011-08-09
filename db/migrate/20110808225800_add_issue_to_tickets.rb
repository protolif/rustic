class AddIssueToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :issue, :string
  end

  def self.down
    remove_column :tickets, :issue
  end
end
