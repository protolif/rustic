class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :ticket_id
      t.integer :price, :null => false, :default => 0
      t.string  :method

      t.timestamps
    end
    add_index :payments, :ticket_id
  end

  def self.down
    drop_table :payments
  end
end
