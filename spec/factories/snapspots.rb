FactoryGirl.define do
  factory :snapspot do
    name "Lake Pier"
    description "A quiet lake with a long, wooden pier."
    address "23 Lake St, Hamburg, NY 14075, USA"
    latitude "42.7172355"
    longitude "-78.8388185"
    user_id 1
    tag_list "lake,water,nature"
  end
end
