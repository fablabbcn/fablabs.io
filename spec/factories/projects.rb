# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title           "Fablabs.io"
    description     "This is the official page for fablabs.io platform project."
    faq             "Q: Can I contribute to the fablabs portal project.\n
                     A: Sure just pick one of the issues on github"
    scope           "We want to improve the way you can build and collaborate on Fablabs projects."
    lab_id          1
    owner_id        1
  end
end
