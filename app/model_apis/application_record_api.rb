class ApplicationRecordAPI
	include ActiveModel::API

	class << self
		def attributes(attributes)
			attributes.each do |attribute|
				attr_accessor attribute.to_sym
			end
		end
	end
end
