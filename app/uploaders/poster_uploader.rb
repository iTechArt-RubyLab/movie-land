class PosterUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'png'

  version :standard do
    process resize_to_fill: [70, 100, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  def public_id
    "posters/#{model.class}/#{model.id}"
  end

  CarrierWave.configure do |config|
    config.cache_storage = :file
  end
end
