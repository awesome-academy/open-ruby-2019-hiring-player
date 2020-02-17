FactoryBot.define do
  factory :user do
    name {FFaker::Name.name}
    email {FFaker::Internet.email}
    password {"123456"}
  end

  factory :order do
    status {0}
    cost {120000}
    rental_period {22}
  end
end
