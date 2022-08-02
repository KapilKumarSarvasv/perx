# frozen_string_literal: true

FactoryBot.define do
  factory :user do |f|
    name { Faker::Lorem.word }
    dob { rand(20.years.ago..10.years.ago) }
  end
end