# frozen_string_literal: true

module ThriftShop
	module AuthenticationError
		class ExpiredToken < ThriftShop::Error
			def initialize
				super(
					code: 'authentication.token.expired',
					status: :unauthorized,
					message: 'Token is expired'
								)
			end
		end
	end
end
