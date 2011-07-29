class AddSerialToComputers < ActiveRecord::Migration
  def self.up
    add_column :computers, :serial, :string
  end

  def self.down
    remove_column :computers, :serial
  end
end
