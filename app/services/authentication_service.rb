class AuthenticationService < ApplicationService
	def initialize(account_repository: ::AccountRepository.new)
		super()

		@account_repository = account_repository

		@jwt_algorithm = Rails.application.secrets.jwt_algorithm || 'HS256'
		@jwt_secret = Rails.application.secrets.secret_key_base
		@jwt_expiration = (DateTime.now + 15.minutes).to_i
	end

	def authenticate(username:, password:, request:)
		account = account_repository.authenticate(username:, password:)

		token = generate_token(account.id)

		request.cookie_jar.signed[:access_token] = { value: token, httponly: true }

		token
	end

	def authenticate_with_token(header)
		token = header.split(' ').last

		decoded_token = JWT.decode(token, jwt_secret, true, { algorithm: jwt_algorithm }).first.symbolize_keys

		account = account_repository.find(decoded_token[:account_id])

		raise ThriftShop::AuthenticationError::InvalidToken unless account

		return account
	rescue JWT::DecodeError
		raise ThriftShop::AuthenticationError::InvalidToken
	rescue JWT::ExpiredSignature
		raise ThriftShop::AuthenticationError::ExpiredToken
	end

	class << self
		def authenticate(username:, password:, request:)
			new.authenticate(username:, password:, request:)
		end

		def authenticate_with_token(token)
			new.authenticate_with_token(token)
		end
	end

	private

	attr_reader :account_repository, :jwt_algorithm, :jwt_secret, :jwt_expiration

	def generate_token(account_id)
		JWT.encode(
			{ account_id: account_id, exp: jwt_expiration },
			jwt_secret,
			jwt_algorithm
		)
	end
end
