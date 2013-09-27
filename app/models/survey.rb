class Survey < ActiveRecord::Base
  # Remember to create a migration!
  has_many :questions
  has_many :participations
  has_many :survey_takers, through: :participations, source: :user

  belongs_to :author, class_name: "User"
end
