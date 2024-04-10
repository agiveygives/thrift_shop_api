class CaseInsensitiveEmailUsername < ActiveRecord::Migration[7.1]
  def change
    remove_index :accounts, :email
    add_index :accounts, 'lower(email)', unique: true

    remove_index :accounts, :username
    add_index :accounts, 'lower(username)', unique: true
  end
end
