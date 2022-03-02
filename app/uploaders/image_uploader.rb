class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'png'

  version :standard do
    process resize_to_fill: [350, 350, :north]
  end

  def public_id
    "images/#{model.class}/#{model.id}"
  end

  CarrierWave.configure do |config|
    config.cache_storage = :file
  end
end
