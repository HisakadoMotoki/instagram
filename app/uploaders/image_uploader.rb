# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
<<<<<<< HEAD
  include CarrierWave::MiniMagick
  process resize_to_limit: [680, 680]
  # process resize_to_limit: [680, 680]
  # require "mini_magick"
  # process resize_to_limit: [400, 400]
=======

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  #require "mini_magick"
  #process resize_to_limit: [400, 400]
>>>>>>> parent of c9e6ba8... Configure Paperclip to use S3
  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extention_white_list
    %w(jpeg png)
  end

  def default_url(*args)
    "default.png"
  end

  version :thumb do
    process resize_to_fill: [150, 150, 'Center']
  end

  version :thumb50 do
    process resize_to_fill: [50, 50, 'Center']
  end

  version :thumb30 do
    process resize_to_fill: [30, 30, 'Center']
  end
  
  version :thumb300 do
    process resize_to_fill: [300, 300, 'Center']
  end

  # version :thumb300 do
  #   process resize_to_fill: [300, 300, 'Center']
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
