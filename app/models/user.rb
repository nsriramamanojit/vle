class User < ActiveRecord::Base
  #Relations
  has_one :user_profile
  #Attributes for User Profile
  accepts_nested_attributes_for :user_profile, :allow_destroy => true
  #validations
  validates :name,:father_name,:dob,:gender, :presence => true, :length => {:maximum => 100}
  validates :mobile_number, :presence => true, :length => {:maximum => 10}#,:uniqueness => true
  validates :phone_number, :length => {:maximum => 10}
  validates :pin, :length => {:maximum => 6},:presence => true
end
