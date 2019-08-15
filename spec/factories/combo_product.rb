FactoryBot.define do
  factory :combo_product do |f|
    f.combo_id {FFaker::Random.rand 10}
    f.product_id {FFaker::Random.rand 10}
    f.count {FFaker::Random.rand 3}
  end
end
