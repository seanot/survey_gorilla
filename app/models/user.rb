class User < ActiveRecord::Base
  has_many :authored_surveys, class_name: "Survey"
  has_many :participations
  has_many :taken_surveys, through: :participations, source: :survey


  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authentication(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil
  end
end
