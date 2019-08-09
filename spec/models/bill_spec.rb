require "rails_helper"

RSpec.describe Bill, :type => :model do

  let (:user) {FactoryBot.create :user}
  let (:table) {FactoryBot.create :table}
  subject {FactoryBot.create :bill, user_id: user.id, table_id: table.id}
  
  
  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:status).of_type :integer}
    it {is_expected.to have_db_column(:user_id).of_type :integer}
    it {is_expected.to have_db_column(:table_id).of_type :integer} 
  end

  context "validations" do
    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of(:name).is_at_least Settings.min_name}
      it {is_expected.to validate_length_of(:name).is_at_most Settings.max_name}
    end

    describe "#status" do
      it {is_expected.to validate_presence_of :status}
    end

    describe "#user_id" do
      it {is_expected.to validate_presence_of :user_id}
    end

    describe "#table_id" do
      it {is_expected.to validate_presence_of :table_id}
    end
  end
    
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :table}
    it {is_expected.to have_many :bill_details}
    it {is_expected.to have_many :products}
    it {is_expected.to have_many :combos}
  end

  context "#unactive?" do
    it do
      subject.status = Settings.bill_status.unactive
      expect(subject.unactive?).to be_truthy
    end
  end

  context "#active?" do
    it do
      subject.status = Settings.bill_status.active
      expect(subject.active?).to be_truthy
    end
  end
end
