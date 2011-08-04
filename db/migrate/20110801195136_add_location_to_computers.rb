class AddLocationToComputers < ActiveRecord::Migration
  def self.up
    add_column :computers, :type,        :string
    add_column :computers, :charger,     :boolean
    add_column :computers, :cpu,         :string
    add_column :computers, :ram,         :string
    add_column :computers, :checked_in,  :datetime
    add_column :computers, :checked_out, :datetime
  end

  def self.down
    remove_column :computers, :type
    remove_column :computers, :charger
    remove_column :computers, :cpu
    remove_column :computers, :ram
    remove_column :computers, :checked_in
    remove_column :computers, :checked_out
  end
end
