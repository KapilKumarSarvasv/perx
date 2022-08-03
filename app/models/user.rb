class User < ApplicationRecord

  #
  # constant
  #

  TIER = {
    standard:   "Standard",
    gold:       "Gold",
    platinum:   "Platinum"
  }  


  after_save :post_save

  #
  # association
  #

  has_many :products
  has_many :rewards


  #
  # validation
  #

  validates :name, :dob, presence: true


  #
  # methods
  #

  def update_points(arg = nil)
    
    product = arg.nil? ? products : products.where(created_at: arg)

    amount_collection = product&.this_year&.collect {|e| e.country == "singapore" ? e.amount : 2*e.amount }
    # non_singapore_collection = product&.this_year&.collect {|e| 2*e.amount if e.country != "singapore" }

    total_amount = amount_collection&.compact&.inject(0) {|sum, number| sum + number} 
    # non_singapore_point = non_singapore_collection&.compact&.inject(0) {|sum, number| sum + number} 
    
    final_points = (((total_amount)/100).to_i)*10
          

    return points = 0 if final_points < 0
    
    return points = final_points + 100 if final_points >= 2000

    return points = final_points
  end


  private
      

  def post_save
    points = update_points(DateTime.current.all_month)
        
    # coffee reward
    if DateTime.current.month == dob.month
      Reward.create(name: Reward::REWARDS[:coffee], user_id: id) unless Reward.find_by(name: Reward::REWARDS[:coffee], user_id: id, created_at: DateTime.current.all_month)&.present?
    end
  end

end