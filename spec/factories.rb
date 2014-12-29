FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

   factory :subject do
    title "foobar"
    description "Lorem ipsum"
    url "123456789abc"
    start_day Date.new(2014, 8, 30)
    end_day Date.new(2014, 9, 21)
    user
  end
end