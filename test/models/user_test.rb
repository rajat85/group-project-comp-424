# == Schema Information
#
# Table name: users
#
#  id                        :bigint           not null, primary key
#  first_name                :string(255)      default(""), not null
#  last_name                 :string(255)      default(""), not null
#  date_of_birth             :datetime         not null
#  email                     :string(255)      default(""), not null
#  encrypted_password        :string(255)      default(""), not null
#  reset_password_token      :string(255)
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0), not null
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(255)
#  last_sign_in_ip           :string(255)
#  confirmation_token        :string(255)
#  confirmed_at              :datetime
#  confirmation_sent_at      :datetime
#  unconfirmed_email         :string(255)
#  failed_attempts           :integer          default(0), not null
#  unlock_token              :string(255)
#  locked_at                 :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  unique_session_id         :string(20)
#  password_changed_at       :datetime
#  last_activity_at          :datetime
#  expired_at                :datetime
#  security_question_id      :integer
#  security_question_answer  :string(255)
#  encrypted_otp_secret      :string(255)
#  encrypted_otp_secret_iv   :string(255)
#  encrypted_otp_secret_salt :string(255)
#  consumed_timestep         :integer
#  otp_required_for_login    :boolean
#  otp_backup_codes          :text(65535)
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
