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
class AccountAPI < ApplicationRecordAPI
	attributes Account::PUBLIC_ATTRIBUTE_NAMES
end
