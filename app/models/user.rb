class User < ActiveRecord::Base
  #Relations
  has_one :user_profile
  #Attributes for User Profile
  accepts_nested_attributes_for :user_profile, :allow_destroy => true
  #validations
  validates :name, :presence => true, :length => {:maximum => 100}
  validates :email, :presence => true, :length => {:maximum => 200},:uniqueness => true
  validates :mobile_number, :presence => true, :length => {:maximum => 10}#,:uniqueness => true
  validates :phone_number, :length => {:maximum => 10}
  validates :pin, :length => {:maximum => 6},:presence => true
end
