class Reward < ApplicationRecord

  #
  # constant
  #

  REWARDS = {
    coffee:     "Coffee",
    cash_back:  "5% Cash Back",
    movie:      "Free Movie Ticket",
    lounge:     "4x Airport Lounge Access",
    bounus:     "Quarterly Bonus"
  }
  
  #
  # association
  #

  belongs_to :user


  #
  # scope
  #

  default_scope { order(created_at: :desc) }
  scope :this_year, ->  { where(created_at: DateTime.current.all_year) }

end
