class AddTel2ToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :tel2, :string
  end

  def self.down
    remove_column :users, :tel2
  end
end
