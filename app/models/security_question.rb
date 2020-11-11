# == Schema Information
#
# Table name: security_questions
#
#  id     :bigint           not null, primary key
#  locale :string(255)      not null
#  name   :string(255)      not null
#
class SecurityQuestion < ApplicationRecord
  validates :locale, presence: true
  validates :name, presence: true, uniqueness: true
end
