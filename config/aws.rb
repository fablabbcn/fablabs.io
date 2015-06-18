require 'aws-sdk'

Aws.config[:stub_responses] = true if Rails.env.test?
Aws.config[:credentials] = Aws::Credentials.new(
                              ENV['S3_KEY'],
                              ENV['S3_SECRET'])
Aws.config[:bucket] = ENV['S3_BUCKET']
Aws.config[:log_level] = Rails.logger.level
Aws.config[:logger] = Rails.logger
