class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process resize_to_fit: [1280, 720]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/fallback/#{[version_name, 'default.png'].compact.join('_')}"
  end

  def extension_allowlist
    %w[jpg jpeg png]
  end

  def filename
    original_filename
  end
end
