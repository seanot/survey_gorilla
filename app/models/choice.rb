class Choice < ActiveRecord::Base
  # Remember to create a migration!
  has_many :responses

  belongs_to :question
end
