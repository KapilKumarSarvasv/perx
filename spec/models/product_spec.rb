require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { build(:product) }

  context "basic attribute" do
    %i[ 
      name amount country 
    ].each do |attr|
      it "has #{attr}" do
        expect(product).to respond_to attr
      end
    end

  end

end
