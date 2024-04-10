# frozen_string_literal: true

require 'test_helper'

module V1
	class AuthenticationControllerTest < ActionDispatch::IntegrationTest
		test 'should get create' do
			get v1_authentication_create_url
			assert_response :success
		end
	end
end
