FactoryBot.define do
  factory :task do
    user
    sequence(:title) { |n| "test_title_#{n}"}
    sequence(:content) { |n| "test_content_#{n}"}
  end
end
