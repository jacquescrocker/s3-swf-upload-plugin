S3SwfUpload Gem For Rails 3
=============================

S3SwfUpload allows user to upload a file to S3 directly, so you can save the cost of uploading process in your app server.

The flex application in this fork was completely re-written so that there are no flash or flex UI components.  The one exception to that is the browse button, which, for security purposes MUST be flash. But even then, you get to pass the URLs for images to use for that button!

The goal of this re-write is to put the power to customize this powerful took back in the hands of non-flex-savvy developers.  The look and feel is controlled by CSS, and any behavior is controlled by JavaScript.  Flex only handles the file management portion.  A nice result of this is that the flash file is only 46 kb, down from 288 kb.  If you see any way that this can be done better, please don't hesitate to let me know!

## Example

![Preview](http://static.nathancolgate.com/images/s3_swf_uploader_screenshot.png)

Watch a video of an example app being built using the gem on [Vimeo](http://vimeo.com/11363680)

There is also a demo app running on heroku at <http://s3swfuploader.heroku.com/>

## Usage

1. Edit `Gemfile` and add this as a gem, you'll also need aws-s3

    gem 's3_swf_upload', :git => 'git://github.com/nathancolgate/s3-swf-upload-plugin'

2. Bundle it!

    $ bundle install

3. Run the generator

    $ rails generate s3_swf_upload:uploader

4. Configure your s3 settings in the generated `config/initializers/s3_swf_upload.rb` file.

5. Run the setup rake task (on all environments)

    $ rake s3_swf_upload:remote_setup

This will create the bucket and set them up with crossdomain.xml configured

6. Initialize the SWF object in your view using this handy helper:

    <%=raw s3_swf_upload_tag %>

7. To achieve basic functionality, the only other thing you need is something to call the `startUploading` function.  For example:

    <input type="submit" value="Start Uploading" onclick="s3_swf_1_object.startUploading();" />

However, you will have no feedback or interface to let you know that anything is actually happening.

8. If you want to customise its behavior, [here's a more complex example](http://gist.github.com/382979)

And the [CSS](http://gist.github.com/383118) to go along.

## General Parameters

* :buttonWidth (integer = 100)

* :buttonHeight (integer = 30)

* :flashVersion (string = '9.0.0')

* :queueSizeLimit (integer = 100)

  Maximum number of files that can be added to the queue.

* :fileSizeLimit (integer = 524288000)

  Individual file size limit in bytes (default is 512 MB)

* :fileTypes (string = '*.*')

  Something like this also works: `'*.jpg;*.gif;*.png;'`

* :fileTypeDescs (string = 'All Files')

  Something like this also works: `'Image files.'`

* :selectMultipleFiles (boolean = true)

  Set this to false if you only want to allow users to pick one file at a time.

* :keyPrefix (string = '')

  String to be prepended to the uploaded file name to make the Amazon S3 key (location in bucket).

* :signaturePath (string = '/s3_uploads.xml')

  Fully qualified path to the controller and action that will serve up the Amazon S3 signature

* :buttonUpPath (string = '/flash/s3_up_button.gif')

  Fully qualified path to an image to be used as the Browse Button (in the up state).  Image should have same dimensions as the buttonWidth and buttonHeight parameters.

* :buttonOverPath (string = '/flash/s3_over_button.gif')

  Fully qualified path to an image to be used as the Browse Button (in the over state).  Image should have same dimensions as the buttonWidth and buttonHeight parameters.

* :buttonDownPath (string = '/flash/s3_down_button.gif')

  Fully qualified path to an image to be used as the Browse Button (in the down state).  Image should have same dimensions as the buttonWidth and buttonHeight parameters.

## Callback Parameters

The real power of this refactoring is that the flex application makes all of the following calls to JavaScript.  What you do with the calls is totally up to you:

* :onFileAdd (file)
* :onFileRemove (file)
* :onFileSizeLimitReached (file)
* :onFileNotInQueue (file)
* :onQueueChange (queue)
* :onQueueSizeLimitReached (queue)
* :onQueueEmpty (queue)
* :onQueueClear (queue)
* :onUploadingStart ()
* :onUploadingStop ()
* :onUploadingFinish ()
* :onSignatureOpen (file,event)
* :onSignatureProgress (file,progress_event)
* :onSignatureSecurityError (file,security_error_event)
* :onSignatureComplete (file,event)
* :onSignatureIOError (file,io_error_event)
* :onSignatureHttpStatus (file,http_status_event)
* :onSignatureXMLError (file,error_message)
* :onUploadError (upload_options,error)
* :onUploadOpen (upload_options,event)
* :onUploadProgress (upload_options,progress_event)
* :onUploadIOError (upload_options,io_error_event)
* :onUploadHttpStatus (upload_options,http_status_event)
* :onUploadSecurityError (upload_options,security_error_event)
* :onUploadComplete (upload_options,event)

## JavaScript Functions

The following functions can be called on the generated object.  Normally the call looks something like this:

    s3_swf_1_object.startUploading();

### startUploading

Starts the uploading process

### stopUploading

Stops the uploading process.  Note: Stopping and restarting the uploading process is buggy.  I'd avoid it.

### clearQueue

Clears all files out of the queue.

### removeFileFromQueue(integer)

Removes a specific file from the queue.


## Will it work with < Rails 3?

You bet.  The Rails 3 specific gem only makes installation and setup easier.  Download the gem to your desktop (or similar non-gem path location) and perform all the Usage steps by hand.  Namely:

1. Copy the [template files](http://github.com/nathancolgate/s3-swf-upload-plugin/tree/master/lib/s3_swf_upload/railties/generators/uploader/templates/ into your application (use the "generator":http://github.com/nathancolgate/s3-swf-upload-plugin/blob/master/lib/s3_swf_upload/railties/generators/uploader/uploader_generator.rb) as a road map)

2. Then copy the [view helpers](http://github.com/nathancolgate/s3-swf-upload-plugin/blob/master/lib/s3_swf_upload/view_helpers.rb) into your applications `/lib` directory.

You'll want to add the view helper to an initialization file: `require 'view_helpers'`

## Known Issues

As much as I would like the interface to be 100% HTML, a (legitimate) security feature in Flash does not allow it:

> "With Adobe Flash Player 10, the `FileReference.browse` and `FileReference.download`  operations may be initiated only through ActionScript that originates from user interaction." - "Adobe TechNote":http://kb2.adobe.com/cps/405/kb405546.html

The next best thing I could come up with was to pass images in as buttons.

If the `startUploading` call is made after calling `stopUploading`, only the first file in the queue is successfully uploaded.

## Kudos

Original plugin is Copyright (c) 2008 elctech, released under the MIT license

Updates to plugin for multiple file uploader are Copyright (c) 2010 PRX, released under the MIT license

Conversion of plugin to gem for rails 3 is Copyright (c) 2010 Nathan Colgate Clark, released under the MIT license

Stripping the flex application of UI and adding callbacks Copyright (c) 2010 Nathan Colgate Clark, released under the MIT license

