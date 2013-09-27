class Choice < ActiveRecord::Base
  # Remember to create a migration!
  has many :responses

  belongs_to :question
end
