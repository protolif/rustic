class CreateComputers < ActiveRecord::Migration
  def self.up
    create_table :computers do |t|
      t.string :make
      t.string :model
      t.integer :user_id

      t.timestamps
    end
    add_index :computers, :user_id
    add_index :computers, :created_at
  end

  def self.down
    drop_table :computers
  end
end
