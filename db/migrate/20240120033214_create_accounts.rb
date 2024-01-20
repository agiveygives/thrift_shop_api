# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts, id: :string do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.jsonb :phone_number, null: false, index: { unique: true }
      t.string :role, null: false, default: 'customer'

      t.timestamps
    end
  end
end
