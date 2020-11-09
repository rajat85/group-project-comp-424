class SecurityQuestion < ApplicationRecord
  validates :locale, presence: true
  validates :name, presence: true, uniqueness: true
  has_one :user
end
