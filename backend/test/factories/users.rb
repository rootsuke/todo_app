FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test_name#{n}"}
  end
end
