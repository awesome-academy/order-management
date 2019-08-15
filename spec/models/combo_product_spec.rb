require "rails_helper"

RSpec.describe ComboProduct, :type => :model do

  let(:combo) {FactoryBot.create :combo}
  let (:product) {FactoryBot.create :product}
  subject {FactoryBot.create :combo_product, combo_id: combo.id, product_id: product.id}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:combo_id).of_type :integer}
    it {is_expected.to have_db_column(:product_id).of_type :integer}
    it {is_expected.to have_db_column(:count).of_type :integer}
  end

  context "validations" do
    describe "#combo_id" do
      it {is_expected.to validate_presence_of :combo_id}
    end

    describe "#product_id" do
      it {is_expected.to validate_presence_of :product_id}
    end

    describe "#count" do
      it {is_expected.to validate_presence_of :count}
    end
  end
    
  context "associations" do
    it {is_expected.to belong_to :combo}
    it {is_expected.to belong_to :product}
  end
end
