class RemoveTypeFromComputers < ActiveRecord::Migration
  def self.up
    remove_column :computers, :type
  end

  def self.down
    remove_column :computers, :type
  end
end
