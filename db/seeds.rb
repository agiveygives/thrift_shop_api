# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

accounts = [
	{
		username: 'tommyFresh',
		email: 'tomhaverford@andrewgivens.net',
		first_name: 'Tom',
		last_name: 'Haverford',
		phone_number: { country_code: '+1', value: '5559182394', type: 'mobile' },
		role: 'admin'
	}
]

accounts.each do |account|
	model = Account.find_by(account)
	Account.create!({ **account, password: 'password' }) unless model
end
