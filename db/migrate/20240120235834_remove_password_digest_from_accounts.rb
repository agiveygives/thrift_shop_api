# frozen_string_literal: true

class RemovePasswordDigestFromAccounts < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :password_digest, :string
  end
end
