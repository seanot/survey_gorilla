class Uploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::RMagick
 
  version :thumb do
    process :resize_to_limit => [50, 50]
  end
 
  storage :file
 
  def store_dir
    'images'
  end
end