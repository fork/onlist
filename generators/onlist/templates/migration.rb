class <%= class_name %> < ActiveRecord::Migration
  def self.up
    create_table :onlists do |t|
      t.references :onlisted, :null => false, :polymorphic => true
      t.boolean :accepted
      t.timestamps
    end

    add_index :onlists, [:onlisted_type, :onlisted_id], :unique => true
  end

  def self.down
    drop_table :onlists
  end
end
