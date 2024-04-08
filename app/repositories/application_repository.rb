# frozen_string_literal: true

class ApplicationRepository
	def initialize
		@model = model
	end

	def find(id)
		model.find(id).to_public
	end

	def find_by(**)
		model.find_by(**).to_public
	end

	def find_by!(**)
		model.find_by!(**).to_public
	end

	def where(**)
		model.where(**).map(&:to_public)
	end

	class << self
		def model(model_class)
			define_method(:model) { model_class }
		end

		def find(id)
			new.find(id)
		end

		def find_by(**)
			new.find_by(**)
		end

		def find_by!(**)
			new.find_by!(**)
		end

		def where(**)
			new.where(**)
		end
	end
end
