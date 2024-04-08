# frozen_string_literal: true

module V1
	class AuthenticationController < ApplicationController
		def login
			token = AuthenticationService.authenticate(username: params[:username], password: params[:password])

			render json: { token: }, status: :ok
		end
	end
end
