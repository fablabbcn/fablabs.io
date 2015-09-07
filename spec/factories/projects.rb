# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title           "Fablabs.io"
    description     "This is the official page for fablabs.io platform project."
    github          "https://github.com/fablabbcn/fablabs"
    web             "https://www.fablabs.io/"
    dropbox         "https://www.dropbox.com/fablabs.io/"
    bitbucket       "https://www.bitbucket.com/fablabs/"
    vimeo           "https://www.vimeo.com/fablabs/"
    flickr          "https://www.flickr.com/photos/fablabs"
    youtube         "https://www.youtube.com/fablabs"
    drive           "https://www.drive.google.com/fablabs"
    twitter         "https://www.twitter.com/fablabs"
    facebook        "https://www.facebook.com/fablabs"
    googleplus      "https://plus.google.com/fablabs"
    instagram       "https://www.instagram.com/fablabs"
    faq             "Q: Can I contribute to the fablabs portal project.\n
                     A: Sure just pick one of the issues on github"
    scope           "We want to improve the way you can build and collaborate on Fablabs projects."
    lab_id          1
    owner_id        1
  end
end
