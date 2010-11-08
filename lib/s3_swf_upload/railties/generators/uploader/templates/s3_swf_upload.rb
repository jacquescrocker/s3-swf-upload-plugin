S3SwfUpload.configure do |config|
  # you probably want to pull these out of ENV variables
  config.s3_bucket = "your_s3_bucket_name"
  config.s3_access_key_id = "your_s3_access_key_id"
  config.s3_secret_access_key = "your_secret_access_key"
  config.s3_acl = :public_read
end