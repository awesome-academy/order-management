require "rails_helper"

RSpec.describe BillDetail, :type => :model do

  let (:user) {FactoryBot.create :user}
  let (:table) {FactoryBot.create :table}
  let (:bill) {FactoryBot.create :bill, user_id: user.id, table_id: table.id}
  let (:combo) {FactoryBot.create :combo}
  subject {FactoryBot.create :bill_detail, bill_id: bill.id, combo_id: combo.id, product_id: nil}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:type_detail).of_type :integer}
    it {is_expected.to have_db_column(:count).of_type :integer}
    it {is_expected.to have_db_column(:price).of_type :float}
    it {is_expected.to have_db_column(:bill_id).of_type :integer}
    it {is_expected.to have_db_column(:product_id).of_type :integer}
    it {is_expected.to have_db_column(:combo_id).of_type :integer}
  end

  context "validations" do
    describe "#count" do
      it {is_expected.to validate_presence_of :count}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :bill}
    it {is_expected.to belong_to :combo}
    it {is_expected.to belong_to :product}
  end

  context "#combo?" do
    it do
      subject.type_detail = Settings.type_detail.combo
      expect(subject.combo?).to be_truthy
    end
  end

  context "#product?" do
    it do
      subject.type_detail = Settings.type_detail.product
      expect(subject.product?).to be_truthy
    end
  end
end
