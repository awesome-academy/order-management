FactoryBot.define do
  factory :combo do |f|
    f.name {FFaker::Name.name}
    f.price {FFaker::Random.rand 10000}
    trait :status do
      allower {Settings.combo_and_product_status.allower}
    end
  end
end
