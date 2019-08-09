require "rails_helper"

RSpec.describe Table, :type => :model do

  subject {FactoryBot.create :table}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:number).of_type :string}
    it {is_expected.to have_db_column(:description).of_type :text}
    it {is_expected.to have_db_column(:amount_chair).of_type :integer}
    it {is_expected.to have_db_column(:status).of_type :integer}
  end

  context "validations" do
    describe "#number" do
      it {is_expected.to validate_presence_of :number}
      it {is_expected.to validate_length_of(:number).is_at_least Settings.min_number_table}
      it {is_expected.to validate_length_of(:number).is_at_most Settings.max_number_table}
    end

    describe "#description" do
      it {is_expected.to validate_presence_of :description}
    end

    context "associations" do
      it {is_expected.to have_many :bills}
    end

    context "#sigle_table?" do
      it do
        subject.amount_chair = Settings.table_type.single_table
        expect(subject.single_table?).to be_truthy
      end
    end
  
    context "#double_table?" do
      it do
        subject.amount_chair = Settings.table_type.double_table
        expect(subject.double_table?).to be_truthy
      end
    end

    context "#four_table?" do
      it do
        subject.amount_chair = Settings.table_type.four_table
        expect(subject.four_table?).to be_truthy
      end
    end

    context "#eight_table?" do
      it do
        subject.amount_chair = Settings.table_type.eight_table
        expect(subject.eight_table?).to be_truthy
      end
    end
  end
end
