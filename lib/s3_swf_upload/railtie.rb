require 's3_swf_upload'
require 'rails'

module S3SwfUpload
  class Railtie < Rails::Railtie

    rake_tasks do
      load "s3_swf_upload/railties/tasks/s3_swf_upload.rake"
    end

    generators do
      require "s3_swf_upload/railties/generators/uploader/uploader_generator"
    end

  end
end
