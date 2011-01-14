class User < ActiveRecord::Base
  # Attributes
  attr_accessible :name, :initials, :login, :email, :password, :password_confirmation

  # Validations
  validates_presence_of :name, :initials, :login, :email, :password

  # Authentication
  acts_as_authentic

  # Class Methods
  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end
end