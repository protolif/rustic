class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :customer_id
      t.integer :computer_id
      t.integer :technician_id

      t.timestamps
    end
    add_index :tickets, :customer_id
    add_index :tickets, :computer_id
    add_index :tickets, :technician_id
  end

  def self.down
    drop_table :tickets
  end
end
