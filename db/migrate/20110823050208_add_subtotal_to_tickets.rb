class AddSubtotalToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :subtotal, :integer, :null => false, :default => 0
    add_column :tickets, :total,    :integer, :null => false, :default => 0
    add_column :tickets, :tax,      :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :tickets, :subtotal
    remove_column :tickets, :total
    remove_column :tickets, :tax
  end
end
