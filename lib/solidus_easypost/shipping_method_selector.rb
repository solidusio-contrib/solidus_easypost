# frozen_string_literal: true

module SolidusEasypost
  class ShippingMethodSelector
    def shipping_method_for(rate)
      ::Spree::ShippingMethod.find_or_create_by(
        carrier: rate.carrier,
        service_level: rate.service,
      ) do |shipping_method|
        shipping_method.name = "#{rate.carrier} #{rate.service}"
        shipping_method.calculator = ::Spree::Calculator::Shipping::FlatRate.create
        shipping_method.shipping_categories = [::Spree::ShippingCategory.first]
        shipping_method.available_to_users = SolidusEasypost.configuration.shipment_method_user_availability
      end
    end
  end
end
