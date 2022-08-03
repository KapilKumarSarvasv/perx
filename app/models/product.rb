class Product < ApplicationRecord

  #
  # constant
  #

  COUNTRY = {
    singapore: "SINGAPORE",
    india:     "INDIA",
    other:     "OTHER"
  }

  #
  # callback
  #
  
  after_save :post_save


  #
  # scope
  #
  
  # default_scope { order(created_at: :desc) }
  scope :this_year, ->  { where(created_at: DateTime.current.all_year) }
  
  #
  # validation
  #

  validates :name, :amount, presence: true


  #
  # association
  #

  belongs_to :user


  private
      

  def post_save

    points = user.update_points(DateTime.current.all_month)
          
    # coffee reward
    if points >= 100 || DateTime.current.month == user.dob.month
      Reward.create(name: Reward::REWARDS[:coffee], user_id: user.id) unless Reward.find_by(name: Reward::REWARDS[:coffee], user_id: user.id, created_at: DateTime.current.all_month)&.present?
    end

    # 5% cash back reward
    if points >= 100 && user.products.this_year.count >= 10
      Reward.create(name: Reward::REWARDS[:cash_back], user_id: user.id) unless Reward.find_by(name: Reward::REWARDS[:cash_back], user_id: user.id, created_at: DateTime.current.all_month)&.present?
    end
    
    # movie reward
    if user.products.this_year.present?
      points = user.update_points(user.products&.this_year&.first&.created_at..user.products&.this_year&.first&.created_at+60.days)

      if points > 1000
        Reward.create(name: Reward::REWARDS[:movie], user_id: user.id) unless Reward.find_by(name: Reward::REWARDS[:movie], user_id: user.id, created_at: DateTime.current.all_month)&.present?
      end
    end

    # 4x Airport Lounge Access
    if (1000..4999).include?(points)
      Reward.create(name: Reward::REWARDS[:lounge], user_id: user.id) unless Reward.find_by(name: Reward::REWARDS[:lounge], user_id: user.id, created_at: DateTime.current.all_month)&.present?
    end
    
    # quarterly bonus
    unless Reward.find_by(name: Reward::REWARDS[:bounus], user_id: user.id, created_at: DateTime.current.all_quarter)&.present?
      quarterly_point = user.update_points(DateTime.current.all_quarter)

      if quarterly_point >= 2000        
        Reward.create(name: Reward::REWARDS[:bounus], user_id: user.id)
      end
    end
    

    return user.update(tier: User::TIER[:standard]) if points == 0 || user.tier.nil? || (0..999).include?(points)
    
    return user.update(tier: User::TIER[:gold]) if (1000..4999).include?(points)

    return user.update(tier: User::TIER[:platinum]) if points >= 5000

  end
  
end
