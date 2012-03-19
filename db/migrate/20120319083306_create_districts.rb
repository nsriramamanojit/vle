class CreateDistricts < ActiveRecord::Migration
  def self.up
    create_table :districts do |t|
      t.integer :state_id
      t.integer :division_id
      t.string  :name
      t.text    :description
      t.text    :short_code
      t.boolean :vle_check, :defalut=>0
      t.integer :dis_number, :default=>0
      t.integer :status, :default=>0
      t.integer :created_by
      t.integer :updated_by


      t.timestamps
    end
  end

  def self.down
    drop_table :districts
  end
end
