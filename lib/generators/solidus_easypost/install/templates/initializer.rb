# frozen_string_literal: true

SolidusEasypost.configure do |config|
  # API Key
  config.api_key = 'YOUR_API_KEY_HERE'

  # Purchase labels from EasyPost when shipping shipments in Solidus?
  # config.purchase_labels = true

  # Create a tracker in EasyPost and receive webhooks for all cartons?
  # config.track_all_cartons = false

  # A class that responds to `#compute`, accepting an `EasyPost::Rate`
  # instance and returning the cost for that rate.
  # config.shipping_rate_calculator_class = 'SolidusEasypost::ShippingRateCalculator'

  # A class that responds to `#shipping_method_for`, accepting an
  # `EasyPost::Rate` instance and returning the shipping method for
  # that rate.
  # config.shipping_method_selector_class = 'SolidusEasypost::ShippingMethodSelector'

  # A class that responds to '#compute', accepting a `SolidusEasypost::ReturnAuthorization`
  # instance or a `Spree::Stock::Package` instance and returing the `SolidusEasypost::ParcelDimension` object.
  # The `SolidusEasypost::Calculator::BaseDimensionCalculator` class can be extended to have a common
  # functionality.
  # config.parcel_dimension_calculator_class = 'SolidusEasypost::Calculator::WeightDimensionCalculator'
end
