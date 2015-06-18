require 'aws-sdk-v1'
require "refile/s3"

aws = {
  access_key_id: ENV['S3_KEY'],
  secret_access_key: ENV['S3_SECRET'],
  region: "eu-west-1",
  bucket: ENV['S3_BUCKET']
}

Refile.cache = Refile::S3.new(prefix: "cache", max_size: 10.megabytes, **aws)
Refile.store = Refile::S3.new(prefix: "store", max_size: 10.megabytes, **aws)
