class UserProfile < ActiveRecord::Base
  #Relations
  belongs_to :user
  belongs_to :state
  belongs_to :division
  belongs_to :district
  belongs_to :block

  validates_presence_of :state_id
  validates_presence_of :division_id
  validates_presence_of :district_id
  validates_presence_of :block_id
  validates :panchayat,:presence => true,:length => 50,:uniqueness => true
end
