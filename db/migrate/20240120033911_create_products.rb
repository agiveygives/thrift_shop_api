# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
	def change
		create_table :products, id: :string do |t|
			t.string :name, null: false
			t.string :description, null: false
			t.integer :price, null: false
			t.integer :discount, default: nil
			t.jsonb :details, null: false
			t.jsonb :tags, null: false

			t.timestamps
		end
	end
end
