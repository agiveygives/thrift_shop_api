# frozen_string_literal: true

class UniqueIndexOnAccountUsernames < ActiveRecord::Migration[7.1]
	def change
		add_index :accounts, :username, unique: true
	end
end
