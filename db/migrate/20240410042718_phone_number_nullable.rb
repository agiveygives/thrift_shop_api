# frozen_string_literal: true

class PhoneNumberNullable < ActiveRecord::Migration[7.1]
	def change
		change_column_default :accounts, :phone_number, from: nil, to: {}
		change_column_null :accounts, :phone_number, true, default: {}
	end
end
