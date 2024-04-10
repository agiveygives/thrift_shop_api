# frozen_string_literal: true

class ApplicationController < ActionController::API
	include ActionController::Cookies
	include AuthenticatedRequest
end
