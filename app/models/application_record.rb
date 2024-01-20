# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  before_create :generate_prefixed_ulid

  primary_abstract_class

  def as_json(options = {})
    super(options).deep_symbolize_keys
  end

  private

  def generate_prefixed_ulid
    self.id = ULID.generate(prefix: self.class.name.downcase)
  end
end
