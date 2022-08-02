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
      product = create(:product, user: user, amount: 1, country: "india")

      expect(user.update_points).to eq(2)
    end
    
  end

end
