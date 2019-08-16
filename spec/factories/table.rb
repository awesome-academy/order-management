FactoryBot.define do
  factory :table do |f|
    f.number {FFaker::Name.name}
    f.description {FFaker::Lorem.paragraph}
    trait :amount_chair do
      double_table {Settings.table_type.double_table}
    end
    trait :status do
      active {Settings.table_status.active}
    end
  end
end
