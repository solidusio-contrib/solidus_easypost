# frozen_string_literal: true

module SolidusEasypost
  class Configuration
    attr_accessor :purchase_labels, :track_all_cartons, :api_key
    attr_writer :shipping_rate_calculator_class, :shipping_method_selector_class, :parcel_dimension_calculator_class,
      :webhook_handler_class

    def initialize
      self.purchase_labels = true
      self.track_all_cartons = false
      @api_key = api_key
    end

    def shipping_rate_calculator_class
      @shipping_rate_calculator_class ||= 'SolidusEasypost::ShippingRateCalculator'
      @shipping_rate_calculator_class.constantize
    end

    def shipping_method_selector_class
      @shipping_method_selector_class ||= 'SolidusEasypost::ShippingMethodSelector'
      @shipping_method_selector_class.constantize
    end

    def parcel_dimension_calculator_class
      @parcel_dimension_calculator_class ||= 'SolidusEasypost::Calculator::WeightDimensionCalculator'
      @parcel_dimension_calculator_class.constantize
    end

    def webhook_handler_class
      @webhook_handler_class ||= 'SolidusEasypost::TrackerWebhookHandler'
      @webhook_handler_class.constantize
    end
  end
end
