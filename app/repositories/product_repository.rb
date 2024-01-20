# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :string           not null, primary key
#  description :string           not null
#  details     :jsonb            not null
#  discount    :integer
#  name        :string           not null
#  price       :integer          not null
#  tags        :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ProductRepository < ApplicationRepository
end
