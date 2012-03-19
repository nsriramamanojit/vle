class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.integer :user_id
      t.integer :state_id
      t.integer :division_id
      t.integer :district_id
      t.integer :block_id
      t.string  :panchayat
      t.string  :csc_code         # CSC Code provided by Govt.
      t.string  :vle_code         # For internal Ref.
      t.text    :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
