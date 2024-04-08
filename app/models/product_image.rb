# frozen_string_literal: true

# == Schema Information
#
# Table name: product_images
#
#  id         :string           not null, primary key
#  active     :boolean          default(TRUE), not null
#  primary    :boolean          default(FALSE), not null
#  thumbnail  :boolean          default(FALSE), not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :string
#
# Indexes
#
#  index_product_images_on_product_id  (product_id)
#  index_product_images_on_url         (url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class ProductImage < ApplicationRecord
	PUBLIC_ATTRIBUTE_NAMES = column_names.freeze
end
