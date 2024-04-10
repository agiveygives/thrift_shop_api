# frozen_string_literal: true

module ThriftShop
	module AuthenticationError
		class InvalidToken < ThriftShop::Error
			def initialize
				super(
					code: 'authentication.token.invalid',
					status: :unauthorized,
					message: 'Token is invalid'
								)
			end
		end
	end
end
