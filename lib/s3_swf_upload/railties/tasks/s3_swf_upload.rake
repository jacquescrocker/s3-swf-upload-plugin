require 's3'

namespace :s3_swf_upload do

  desc "Setup s3 swf upload to start accepting uploads (creates bucket and crossdomain.xml file)"
  task :remote_setup => :environment do
    bucket = find_or_create_bucket
    file_path = File.expand_path(File.join(File.dirname(__FILE__), 'crossdomain.xml'))

    puts "Creating crossdomain.xml within bucket: #{bucket.name}"
    new_object = bucket.objects.build("crossdomain.xml")
    new_object.content = open(file_path)
    new_object.acl = :public_read
    new_object.save
  end

  def find_or_create_bucket
    bucket_name = S3SwfUpload.s3_bucket

    s3_service = S3::Service.new({
      :access_key_id => S3SwfUpload.s3_access_key_id,
      :secret_access_key => S3SwfUpload.s3_secret_access_key
    })

    begin
      s3_service.buckets.find(bucket_name)
    rescue S3::Error::NoSuchBucket
      puts "Creating bucket: #{bucket_name}"
      bucket = s3_service.buckets.build(bucket_name)
      bucket.save
      bucket
    end
  end
end