class AccountService < ApplicationService
	def initialize(authentication_service: AuthenticationService.new, account_repository: AccountRepository.new)
		super()

		@authentication_service = authentication_service
		@account_repository = account_repository
	end

	def create_and_authenticate(params)
		create_and_authenticate_validate_params(params)

		authentication_service.create_account_and_authenticate(params)
	end

	private

	def create_and_authenticate_validate_params(params)
	end

	attr_reader :authentication_service, :account_repository
end
