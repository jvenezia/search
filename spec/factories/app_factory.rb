FactoryGirl.define do
  factory :app do
    sequence(:name) { |i| "name_#{i}" }
    sequence(:category) { |i| "category_#{i}" }
    link 'http://www.zelda.io'
    rank 5
  end
end