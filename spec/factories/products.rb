# frozen_string_literal: true

FactoryBot.define do
  factory :product do |f|
    name { Faker::Lorem.word }
    amount { rand(10..200) }
    country { ["singapore", "india", "other"].sample }
    user
  end
end