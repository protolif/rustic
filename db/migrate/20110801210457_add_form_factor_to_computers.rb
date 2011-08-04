class AddFormFactorToComputers < ActiveRecord::Migration
  def self.up
    add_column :computers, :form_factor, :string
  end

  def self.down
    remove_column :computers, :form_factor
  end
end
