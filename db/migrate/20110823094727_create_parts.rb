class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.string  :item
      t.integer :ticket_id
      t.integer :price, :null => false, :default => 0
      t.integer :qty, :null => false, :default => 1
      t.string  :warranty

      t.timestamps
    end
    add_index :parts, :ticket_id
  end

  def self.down
    drop_table :parts
  end
end
