class Student < ApplicationRecord
  mount_base64_uploader :photo, PhotoUploader
  has_many :appointments
  has_one :account, as: :account_user, dependent: :destroy
end
