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
class AccountRepository < ApplicationRepository
	model ::Account

	def create!(params)
		model.create!(params).to_public
	end

	def authenticate(username:, password:)
		account = model.find_by(username:)

		raise ThriftShop::AuthenticationError::InvalidCredentials unless account&.authenticate(password)

		account.to_public
	end

	class << self
		def create!(params)
			new.create!(params)
		end

		def authenticate(username:, password:)
			new.authenticate(username:, password:)
		end
	end
end
