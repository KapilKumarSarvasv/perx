class User < ApplicationRecord

  #
  # association
  #

  has_many :products


  #
  # validation
  #

  validates :name, :dob, presence: true
  
  #
  # methods
  #

  def update_points
    
    singapore_collection = products.collect {|e| e.amount if e.country == "singapore" }
    non_singapore_collection = products.collect {|e| 2*e.amount if e.country != "singapore" }

    singapore_point = singapore_collection.compact.inject(0) {|sum, number| sum + number} 
    non_singapore_point = non_singapore_collection.compact.inject(0) {|sum, number| sum + number} 
    
    return points = 0 if singapore_point < 0 && non_singapore_point < 0
    
    return points = ((singapore_point/100).to_i)*10 + (non_singapore_point.to_i)
    
  end

end