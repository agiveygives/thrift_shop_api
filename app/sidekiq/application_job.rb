# frozen_string_literal: true

class ApplicationJob
  include Sidekiq::Worker

  queue_as :default

  sidekiq_options retry: 3, backtrace: true
end
