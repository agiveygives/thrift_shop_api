module V1
	class AuthenticationController < ApplicationController
		def login
			token = AuthenticationService.authenticate(
				username: params[:username],
				password: params[:password],
				request:
			)

			render json: { token: token }, status: :ok
		end
	end
end
