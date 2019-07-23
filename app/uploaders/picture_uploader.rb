class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]

  storage :file

  def store_dir
    "uploads"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url
    ActionController::Base.helpers.asset_path("default.png")
  end
end
