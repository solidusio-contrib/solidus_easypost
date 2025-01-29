# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'
require 'deface'
require 'easypost'

require 'solidus_easypost/version'
require 'solidus_easypost/engine'
require 'solidus_easypost/configuration'
require 'solidus_easypost/address_builder'
require 'solidus_easypost/parcel_builder'
require 'solidus_easypost/shipment_builder'
require 'solidus_easypost/estimator'
require 'solidus_easypost/shipping_rate_calculator'
require 'solidus_easypost/shipping_method_selector'
require 'solidus_easypost/calculator/base_dimension_calculator'
require 'solidus_easypost/calculator/weight_dimension_calculator'
require 'solidus_easypost/tracker_webhook_handler'
require 'solidus_easypost/errors/unknown_partial_resource_error'

module SolidusEasypost
  class << self
    attr_reader :client

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
      @client = ::EasyPost::Client.new(api_key: @configuration.api_key)
    end
  end
end
