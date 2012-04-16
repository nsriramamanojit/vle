class Block < ActiveRecord::Base
  has_many :panchayats
  belongs_to :division
  belongs_to :district

  validates :division_id, :presence => true
  validates :district_id, :presence => true
  validates :name, :presence => true, :length => {:maximum => 100}

  #search and recent
  class << self
    def recent
      order('created_at DESC').limit(4)
    end

    def search(query)
      if query
        #where(:name.matches => "%#{query}%") #from meta_where gem
        joins(:division,:district).where({:name.matches => "%#{query}%"}|{:divisions => [:name.matches => "%#{query}%"]}| {:districts => [:name.matches => "%#{query}%"]})
      else
        scoped
      end
    end
    def active
      where(:status => true).order('name ASC')
    end
  end      # end of class self

end
