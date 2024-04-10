# frozen_string_literal: true

class JSONSerializer
	class << self
		def dump(object)
			object.is_a?(String) ? object : JSON.generate(object)
		end

		def load(string)
			return if string.nil?

			JSON.parse(string, symbolize_names: true)
		end
	end
end
