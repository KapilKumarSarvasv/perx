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
  # validation
  #

  validates :name, :amount, presence: true


  #
  # association
  #

  belongs_to :user

  
end
