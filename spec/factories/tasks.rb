FactoryGirl.define do
  factory :task do
    user nil
    title "MyString"
    content "MyText"
    deadline "2016-08-03 20:11:34"
    charge_id 1
    done false
    status 1
  end
end
