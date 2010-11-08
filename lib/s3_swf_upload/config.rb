module S3SwfUpload
  class Config #:nodoc
    include Singleton

    attr_accessor \
      :s3_bucket,
      :s3_access_key_id,
      :s3_secret_access_key,
      :s3_acl

  end
end