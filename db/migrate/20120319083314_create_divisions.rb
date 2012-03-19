class CreateDivisions < ActiveRecord::Migration
  def self.up
    create_table :divisions do |t|
      t.integer :state_id
      t.string :name
      t.text   :description
      t.string :short_code
      t.integer :status,:default=>0
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :divisions
  end
end
