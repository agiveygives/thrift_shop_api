# frozen_string_literal: true

class AuthenticationService < ApplicationService
	def initialize(account_repository: ::AccountRepository.new)
		super()

		@account_repository = account_repository

		@jwt_algorithm = Rails.application.secrets.jwt_algorithm || 'HS256'
		@jwt_secret = Rails.application.secrets.secret_key_base
		@access_token_expiration = (DateTime.now + 15.minutes).to_i
		@refresh_token_expiration = (DateTime.now + 2.hours).to_i
	end

	def authenticate(username:, password:, request:)
		account = account_repository.authenticate(username:, password:)

		{
			access_token: generate_token(:access, { account_id: account.id}, request),
			refresh_token: generate_token(:refresh, { account_id: account.id }, request)
		}
	end

	def authenticate_with_access_token(request)
		token = request.cookie_jar.signed[:access_token] || request.headers['Authorization'].split(' ').last

		raise ThriftShop::AuthenticationError::MissingToken if token.blank?

		decoded_token = JWT.decode(token, jwt_secret, true, { algorithm: jwt_algorithm }).first.symbolize_keys

		raise ThriftShop::AuthenticationError::InvalidToken unless decoded_token[:type] == "access"

		account = account_repository.find(decoded_token[:account_id])

		raise ThriftShop::AuthenticationError::InvalidToken unless account

		# Sliding expiration, if a user is active (i.e. using a valid access token), the expiration time is extended
		generate_token(:access, { account_id: account.id}, request)
		generate_token(:refresh, { account_id: account.id }, request)

		account
	rescue JWT::DecodeError
		raise ThriftShop::AuthenticationError::InvalidToken
	rescue JWT::ExpiredSignature
		# If the access token has expired, attempt to refresh with the refresh token
		authenticate_with_refresh_token(request)
	end

	def authenticate_with_refresh_token(request)
		refresh_token = request.cookie_jar.signed[:refresh_token] || request.headers['Authorization'].split(' ').last

		raise ThriftShop::AuthenticationError::MissingToken if token.blank?

		decoded_token = JWT.decode(refresh_token, jwt_secret, true, { algorithm: jwt_algorithm }).first.symbolize_keys

		raise ThriftShop::AuthenticationError::InvalidToken unless decoded_token[:type] == "refresh"

		account = account_repository.find(decoded_token[:account_id])

		raise ThriftShop::AuthenticationError::InvalidToken unless account
	rescue JWT::DecodeError
		raise ThriftShop::AuthenticationError::InvalidToken
	rescue JWT::ExpiredSignature
		raise ThriftShop::AuthenticationError::ExpiredToken
	end

	class << self
		def authenticate(username:, password:, request:)
			new.authenticate(username:, password:, request:)
		end

		def authenticate_with_access_token(request)
			new.authenticate_with_access_token(request)
		end

		def authenticate_with_refresh_token(request)
			new.authenticate_with_refresh_token(request)
		end
	end

	attr_reader :access_token_expiration, :refresh_token_expiration

	private

	attr_reader :account_repository, :jwt_algorithm, :jwt_secret

	def generate_token(type, value, request)
		token = JWT.encode(
			{ **value, type:, exp: send("#{type}_token_expiration".to_sym) },
			jwt_secret,
			jwt_algorithm
		)

		set_cookie(request, "#{type}_token", token)

		token
	end

	def set_cookie(request, name, value)
		request.cookie_jar.signed[name.to_sym] = {
			value: value,
			domain: Rails.application.config.thrift_shop.domain,
			path: '/',
			secure: Rails.env.production?,
			samesite: "strict",
			httponly: true
		}
	end
end
