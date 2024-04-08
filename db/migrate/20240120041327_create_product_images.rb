# frozen_string_literal: true

class CreateProductImages < ActiveRecord::Migration[7.1]
	def change
		create_table :product_images, id: :string do |t|
			t.references :product, foreign_key: true, type: :string
			t.string :url, null: false, index: { unique: true }
			t.boolean :primary, null: false, default: false
			t.boolean :thumbnail, null: false, default: false
			t.boolean :active, null: false, default: true

			t.timestamps
		end
	end
end
