FactoryBot.define do
  factory :user do |f|
    f.name {FFaker::Name.name}
    f.username {FFaker::Lorem.characters 10}
    f.password_digest {FFaker::InternetSE.password}
    f.address {FFaker::Address.city}
    trait :role do
      manager {Settings.role.manager}
    end
    f.phone {FFaker::PhoneNumber.phone_number}
    f.created_at {Time.zone.now}
    f.updated_at {Time.zone.now}
  end
end
