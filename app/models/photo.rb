class Photo < ActiveRecord::Base

  belongs_to :user

  mount_uploader :file, Uploader  
end
