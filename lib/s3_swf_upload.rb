require 'patch/integer'
require 's3_swf_upload/config'
require 's3_swf_upload/signature'
require 's3_swf_upload/view_helpers'
require 's3_swf_upload/railtie' if defined?(Rails)

module S3SwfUpload

  class << self
    def configure
      config = ::S3SwfUpload::Config.instance
      block_given? ? yield(config) : config
    end

    alias :config :configure
  end

  # allow config methods to be accessed directly
  S3SwfUpload::Config.public_instance_methods(false).each do |name|
    (class << self; self; end).class_eval <<-EOT
      def #{name}(*args)
        config.send("#{name}", *args)
      end
    EOT
  end

end
