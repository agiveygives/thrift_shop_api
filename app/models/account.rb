# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id              :string           not null, primary key
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  password_digest :string           not null
#  phone_number    :jsonb
#  role            :string           default("customer"), not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_accounts_on_lower_email     (lower((email)::text)) UNIQUE
#  index_accounts_on_lower_username  (lower((username)::text)) UNIQUE
#  index_accounts_on_phone_number    (phone_number) UNIQUE
#
class Account < ApplicationRecord
	has_secure_password

	PUBLIC_ATTRIBUTE_NAMES = (column_names - %w[password_digest]).freeze

	model_api AccountAPI

	enum role: {
		admin: "admin",
		customer: "customer",
		seller: "seller"
	}

	attribute :phone_number, default: {}
  serialize :phone_number, coder: JSONSerializer

	attribute :role, default: "customer"

	validates :email, presence: true, uniqueness: { case_sensitive: false }
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :password, presence: true
	validates :role, presence: true
	validates :username, presence: true, uniqueness: { case_sensitive: false }

	validate :validate_unique_phone_number

	private

	def validate_unique_phone_number
		return if phone_number.blank?

		account_with_phone_number = Account
			.where("phone_number ->> 'value' = ?", phone_number["value"])
			.and(Account.where("phone_number ->> 'country_code' = ?", phone_number["country_code"]))
			.exists?

		errors.add(:phone_number, "has already been taken") if account_with_phone_number
	end
end
