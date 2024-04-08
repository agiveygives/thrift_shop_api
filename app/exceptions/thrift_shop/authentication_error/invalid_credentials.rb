module ThriftShop
	module AuthenticationError
		class InvalidCredentials < ThriftShop::Error
			def initialize
				super(
					code: 'authentication.credentials.invalid',
					status: :unauthorized,
					message: 'Invalid username or password'
				)
			end
		end
	end
end
