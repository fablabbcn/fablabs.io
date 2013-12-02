# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    user nil
    action "MyString"
    trackable nil
    created_at "2013-12-02 21:37:50"
  end
end
