# frozen_string_literal: true

class ApplicationRepository
  def initialize
    @model = model
    @factory = factory
  end

  def find(**)
    model.find_by(**).as_json
  end

  def find_by(**)
    model.find_by(**).as_json
  end

  def find_by!(**)
    model.find_by!(**).as_json
  end

  def where(**)
    model.where(**).as_json
  end

  protected

  def model; end

  def factory; end
end
