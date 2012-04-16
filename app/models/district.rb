class District < ActiveRecord::Base
  belongs_to :division
  class << self
    def active
      where(:status => true ).order('name')
    end
  end

end
