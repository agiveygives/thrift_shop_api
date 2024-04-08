# frozen_string_literal: true

module ThriftShop
	class Error < StandardError
		# Generic error class for ThriftShop
		#
		# @param code [String] a unique string code for the error. Example: 'authentication.credentials.invalid'
		# @param status [Symbol] the HTTP status code for the error.
		# @param message [String] a human-readable message for the error.
		def initialize(code:, status:, message:)
			@code = code
			@status = status
			@message = message

			super(message)
		end

		attr_reader :code, :status, :message
	end
end
