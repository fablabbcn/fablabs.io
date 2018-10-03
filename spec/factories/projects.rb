# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :project do |f|
    f.association :lab
    f.association :owner
    f.title           "Fablabs.io"
    f.description     "This is the official page for fablabs.io platform project."
    f.faq             "Q: Can I contribute to the fablabs portal project.\n
                     A: Sure just pick one of the issues on github"
    f.scope           "We want to improve the way you can build and collaborate on Fablabs projects."
  end
end
