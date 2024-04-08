# frozen_string_literal: true

require 'test_helper'

module V1
	class AccountControllerTest < ActionDispatch::IntegrationTest
		test 'should get create' do
			get v1_account_create_url
			assert_response :success
		end
	end
end
