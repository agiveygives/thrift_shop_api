# frozen_string_literal: true

class CreateAccountSettings < ActiveRecord::Migration[7.1]
	def change
		create_table :account_settings, id: :string do |t|
			t.references :account, foreign_key: true, null: false, index: { unique: true }, type: :string
			t.string :theme, null: false, default: 'light'
			t.string :language, null: false, default: 'en'
			t.string :currency, null: false, default: 'usd'

			t.timestamps
		end
	end
end
