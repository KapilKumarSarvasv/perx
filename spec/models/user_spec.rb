require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context "basic attributes" do
    
    %i[
      name dob points 
    ].each do |attr|
      it "has #{attr}" do
        expect(user).to respond_to attr
      end
    end

  end


  context "association" do

    %i[ products ].each do |association|
      it "can have a collection of #{association}" do
        expect(user.send(association)).to eq []
      end
    end

  end


  context "validation" do

    it "must have name" do
      expect(user).to be_valid
      expect(build(:user, name: nil)).not_to be_valid
    end

    it "must have dob" do
      expect(user).to be_valid
      expect(build(:user, dob: nil)).not_to be_valid
    end

  end


  context "update points" do

    it "no point for user hasn't spent" do
      expect(user.update_points).to eq(0)
    end
    
    it "for every amount spend less than $100 the end user spends they receive 0 point" do
      # user = create(:user)
      product = build(:product, user: user, amount: rand(1..99), country: "singapore")

      expect(user.update_points).to eq(0)
    end

    it "for every $100 the end user spends they receive 10 points" do
      user = create(:user)
      product = create(:product, user: user, amount: 199, country: "singapore")

      expect(user.update_points).to eq(10)
    end

    it "for any amount the end user spends they receive 2*amount points" do
      user = create(:user)
      Product.destroy_all
      product = create(:product, user: user, amount: 100, country: "india")

      expect(user.update_points).to eq(20)
    end
    
  end


  context "reward" do

    it "If the end user accumulates 100 points in one calendar month they are given a Free Coffee reward" do
      # user = create(:user)
      
      # Product.destroy_all
      # product = create(:product, user: user, amount: 1200, country: "singapore")
      
      # Reward.destroy_all
      # reward = create(:reward, user: user, name: "coffee")
      
      # expect(user.update_points(DateTime.current.all_month)).to eq(reward)
    end

    it "A 5% Cash Rebate reward is given to all users who have 10 or more transactions that have an amount > $100" do
    end

    it "A Free Movie Tickets reward is given to new users when their spending is > $1000 within 60 days of their first transaction" do
    end

  end


  context "Tiers" do

    it "A standard tier customer is an end user who accumulates 0 points" do
      user = create(:user)
      product = create(:product, user: user, amount: rand(0..9999))
      user.update(points: user.update_points)
      
      expect(user.tier).to eq(User::TIER[:standard])
    end

    it "A gold tier customer is an end user who accumulates 1000 points" do
      # user = create(:user)
      # product = create(:product, user: user, amount: rand(10000..99999), country: "singapore")
      
      # user.update(points: user.update_points)

      # expect(user.tier).to eq(User::TIER[:gold])
    end

    it "A platinum tier customer is an end user who accumulates 5000 points" do
    #   user = create(:user)
    #   product = create(:product, amount: 54300, user: user)
      # user.update(points: user.update_points)

    #   expect(user.tier).to eq(User::TIER[:standard])
    end

  end

end
