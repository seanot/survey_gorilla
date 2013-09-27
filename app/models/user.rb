class User < ActiveRecord::Base
  has_many :authored_surveys, class_name: "Survey"
  has_many :participations
  has_many :taken_surveys, through: :participations, source: :survey
end
