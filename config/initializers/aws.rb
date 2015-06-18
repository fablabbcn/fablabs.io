require 'aws/s3'

AWS.config(
  access_key_id: ENV["S3_KEY"],
  secret_access_key: ENV["S3_SECRET"])
