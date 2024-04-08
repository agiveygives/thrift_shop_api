module AuthenticatedRequest
	extend ActiveSupport::Concern

	included do
		def self.authenticate_request(**options)
			before_action(**options) do
				raise ThriftShop::AuthenticationError::MissingToken if request.headers['Authorization'].blank?

				@current_account = AuthenticationService.authenticate_with_token(request.headers['Authorization'])
			end
		end
	end
end