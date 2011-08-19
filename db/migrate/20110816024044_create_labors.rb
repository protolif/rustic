class CreateLabors < ActiveRecord::Migration
  def self.up
    create_table :labors do |t|
      t.string :service
      t.integer :price, :null => false, :default => 0
      t.string :notes
      t.integer :ticket_id

      t.timestamps
    end
    add_index :labors, :ticket_id
  end

  def self.down
    drop_table :labors
  end
end
