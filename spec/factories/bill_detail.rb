FactoryBot.define do
  factory :bill_detail do |f|
    f.count {FFaker::Random.rand 3}
    trait :type_detail do
      combo {Settings.type_detail.combo}
    end
    f.price {FFaker::Random.rand 10000}
    f.bill_id {FFaker::Random.rand 10}
    f.product_id {FFaker::Random.rand 10}
    f.combo_id {FFaker::Random.rand 10}
  end
end
