require "rails_helper"

RSpec.describe Combo, :type => :model do

  subject {FactoryBot.create :combo}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:price).of_type :float}
    it {is_expected.to have_db_column(:status).of_type :integer}
  end

  context "validations" do
    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of(:name).is_at_least Settings.min_name_combo}
      it {is_expected.to validate_length_of(:name).is_at_most Settings.max_name_combo}
    end

    describe "#price" do
      it {is_expected.to validate_presence_of :price}
    end
  end
    
  context "associations" do
    it {is_expected.to have_many :bill_details}
    it {is_expected.to have_many :bills}
    it {is_expected.to have_many :combo_products}
    it {is_expected.to have_many :products}
  end

  context "#unallowed?" do
    it do
      subject.status = Settings.unallowed
      expect(subject.combo_and_product_status.unallowed?).to be_truthy
    end
  end

  context "#allowed?" do
    it do
      subject.status = Settings.combo_and_product_status.allowed
      expect(subject.allowed?).to be_truthy
    end
  end
end
