class Division < ActiveRecord::Base
  has_many :districts
  has_many :blocks
  has_many :panchayats

  class << self
  def active
    where(:status => true ).order('name')
  end
  end

end
