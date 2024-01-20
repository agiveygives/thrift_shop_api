# frozen_string_literal: true

# == Schema Information
#
# Table name: account_settings
#
#  id         :string           not null, primary key
#  currency   :string           default("usd"), not null
#  language   :string           default("en"), not null
#  theme      :string           default("light"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :string           not null
#
# Indexes
#
#  index_account_settings_on_account_id  (account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class AccountSetting < ApplicationRecord
end
