# frozen_string_literal: true

module AuthenticatedRequest
	extend ActiveSupport::Concern

	included do
		def self.authenticate_request(**)
			before_action(**) do
				@current_account = AuthenticationService.authenticate_with_access_token(request)
			end
		end
	end
end
