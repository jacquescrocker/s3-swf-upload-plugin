Gem::Specification.new do |s|
  s.name = "s3_swf_upload"
  s.version = "0.4.0"
  s.authors = ["Nathan Colgate"]
  s.description = "Rails 3 gem that allows you to upload files directly to S3 from your application using flex for file management, css for presentation, and javascript for behavior."
  s.summary = "Rails 3 gem that allows you to upload files directly to S3 from your application using flex for file management, css for presentation, and javascript for behavior."
  s.email = "nathan@brandnewbox.com"
  s.homepage = "http://github.com/nathancolgate/s3-swf-upload-plugin"

  s.require_paths = ["lib"]

  s.files = Dir['lib/**/*',
                'flex_src/**/*',
                's3_swf_upload.gemspec',
                'Rakefile',
                'CHANGELOG',
                'MIT-LICENSE',
                'README.textile']

  s.add_dependency 's3', ">= 0.3.7"

  s.extra_rdoc_files = ["README.textile", "CHANGELOG", "MIT-LICENSE"]
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "S3_swf_upload", "--main", "README.textile"]
  s.rubyforge_project = "s3_swf_upload"
end
