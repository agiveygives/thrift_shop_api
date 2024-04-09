# frozen_string_literal: true

module V1
	class AuthenticationController < ApplicationController
		def login
			tokens = AuthenticationService.authenticate(
				username: params[:username],
				password: params[:password],
				request:,
			)

			render json: tokens, status: :ok
		end

		def refresh
			AuthenticationService.authenticate_with_refresh_token(request)

			render status: :no_content
		end
	end
end
