# frozen_string_literal: true

module V1
	class AccountController < ApplicationController
		authenticate_request only: [:show]

		def show
			account = AccountRepository.find(params[:id])

			render json: account, status: :ok
		end

		def create; end
	end
end
