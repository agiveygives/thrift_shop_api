# frozen_string_literal: true

module V1
	class AccountController < ApplicationController
		authenticate_request only: [:show]

		def show
			account = AccountRepository.find(show_account_params[:id])

			render json: account, status: :ok
		end

		def show_account_params
			params.permit(:id)
		end
		private :show_account_params

		def create
			account = AccountRepository.create!(create_account_params)

			render json: account, status: :created
		end

		def create_account_params
			params.permit(
				:email,
				:first_name,
				:last_name,
				:password,
				:username,
				phone_number: %i[value country_code type]
			)
		end
		private :create_account_params
	end
end
