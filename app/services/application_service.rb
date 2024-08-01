# frozen_string_literal: true

# app/services/application_service.rb

require "uri"
require "net/http"
require "openssl"

class ApplicationService
  class << self
    def call(*args, &block)
      new(*args, &block).call
    end
  end
end
