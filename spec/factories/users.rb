FactoryGirl.define do
  factory :user do
    username "johndoe"
    email "johndoe@example.com"
    first_name "John"
    last_name  "Doe"
    password "ruby123"
    password_confirmation "ruby123"
  end
end
