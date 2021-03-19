class Account < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  # account_user can be either student or teacher
  belongs_to :account_user, polymorphic: true, dependent: :destroy
end
