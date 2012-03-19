class District < ActiveRecord::Base
  class << self
    def active
      where(:status => true ).order('name')
    end
  end

end
