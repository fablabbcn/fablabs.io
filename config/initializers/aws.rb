require 'aws-sdk-s3'

Aws.config.update({
  credentials: Aws::Credentials.new(ENV["AWS_KEY"], ENV["AWS_SECRET"])
})
