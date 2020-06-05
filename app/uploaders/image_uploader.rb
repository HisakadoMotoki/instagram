# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # require "mini_magick"
  # process resize_to_limit: [400, 400]
  # Choose what kind of storage to use for this uploader:
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

  def extention_white_list
    %w[jpeg png]
  end

  def default_url(*_args)
    'default.png'
  end
end
