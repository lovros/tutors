class Teacher < ApplicationRecord
  validates_uniqueness_of :email
  has_secure_password
  has_many :appointments
end