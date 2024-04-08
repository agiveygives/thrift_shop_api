# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  before_create :generate_prefixed_ulid

  primary_abstract_class

  def to_public
    model_api.new(public_attributes)
  end

  protected

  def public_attributes
    self.attributes.filter { |key, _| self.class::PUBLIC_ATTRIBUTE_NAMES.include?(key) }
  end

  private

  def generate_prefixed_ulid
    self.id = self.class.name.downcase + "_" + ULID.generate
  end

  class << self
    def model_api(model_api_class)
      define_method(:model_api) { model_api_class }
    end
  end
end
