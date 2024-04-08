module ThriftShop
	module AuthenticationError
		class MissingToken < ThriftShop::Error
			def initialize
				super(
					code: 'authentication.token.missing',
					status: :unauthorized,
					message: 'Token is missing'
				)
			end
		end
	end
end
