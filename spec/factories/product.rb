FactoryBot.define do
  factory :product do |f|
    f.name {FFaker::Name.name}
    f.price {FFaker::Random.rand 10000}
    f.image {FFaker::Lorem.characters 10}
    trait :status do
      allower {Settings.combo_and_product_status.allower}
    end
  end
end
