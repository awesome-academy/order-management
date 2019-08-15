FactoryBot.define do
  factory :bill do |f|
    f.name {FFaker::Name.name}
    f.status {Settings.bill_status.active}
    f.user_id {FFaker::Random.rand 10}
    f.table_id {FFaker::Random.rand 10}
  end
end
