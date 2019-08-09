FactoryBot.define do
  factory :table do |f|
    f.number {FFaker::Name.name}
    f.description {FFaker::Lorem.paragraph}
    f.amount_chair {2}
    trait :status do
      active {Settings.table_status.active}
    end
  end
end
