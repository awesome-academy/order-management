require "rails_helper"

RSpec.describe User, :type => :model do

  subject {FactoryBot.create :user}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:phone).of_type :string}
    it {is_expected.to have_db_column(:address).of_type :string}
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:username).of_type :string}
    it {is_expected.to have_db_column(:role).of_type :integer}
    it {is_expected.to have_db_column(:created_at).of_type :datetime}
    it {is_expected.to have_db_column(:updated_at).of_type :datetime}
    it {is_expected.to have_db_column(:password_digest).of_type :string}
  end

  context "validations" do
    describe "#username" do
      it {is_expected.to validate_presence_of :username}
      it {expect(subject.username).to match(Settings.VALID_USERNAME_REGEX)}
      it {is_expected.to validate_length_of(:username).is_at_most Settings.max_username}
      it {is_expected.to validate_uniqueness_of(:username).case_insensitive}
    end

    describe "#password" do
      it {is_expected.to have_secure_password}
      it {is_expected.to validate_length_of(:password).is_at_least Settings.min_password}
      it {is_expected.to validate_uniqueness_of(:username).case_insensitive}
    end

    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of(:name).is_at_least Settings.min_name}
      it {is_expected.to validate_length_of(:name).is_at_most Settings.max_name}
    end

    describe "#phone" do
      it {is_expected.to validate_presence_of :phone}
      it {is_expected.to validate_length_of(:phone).is_at_least Settings.min_phone}
      it {is_expected.to validate_length_of(:phone).is_at_most Settings.max_phone}
    end

    describe "#address" do
      it {is_expected.to validate_presence_of :address}
      it {is_expected.to validate_length_of(:address).is_at_least Settings.min_address}
      it {is_expected.to validate_length_of(:address).is_at_most Settings.max_address}
    end

    context "associations" do
      it {is_expected.to have_many :bills}
    end

    context "#manager?" do
      it do
        subject.role = Settings.role.manager
        expect(subject.manager?).to be_truthy
      end
    end
  
    context "#chef?" do
      it do
        subject.role = Settings.role.chef
        expect(subject.chef?).to be_truthy
      end
    end

    context "#waiter?" do
      it do
        subject.role = Settings.role.waiter
        expect(subject.waiter?).to be_truthy
      end
    end
  end
end
