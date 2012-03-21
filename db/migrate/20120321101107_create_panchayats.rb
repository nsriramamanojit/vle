class CreatePanchayats < ActiveRecord::Migration
  def self.up
    create_table :panchayats do |t|
      t.string  :name
      t.text    :description

      t.integer :state_id
      t.integer :division_id
      t.integer :district_id
      t.integer :block_id
      t.boolean :status, :default=>1

      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :panchayats
  end
end
