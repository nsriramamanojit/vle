class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :father_name
      t.string :gender
      t.date :dob
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :place
      t.string :pin
      t.string :mobile_number
      t.string :phone_number
      t.string :verification_code
      t.string :verification_date
      t.integer :created_by
      t.integer :updated_by
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.boolean :approved, :default=>0


      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
