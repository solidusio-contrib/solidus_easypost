# frozen_string_literal: true

module SolidusEasypost
  class Estimator
    def shipping_rates(package, _frontend_only = true)
      shipment = package.shipment

      if shipment.easypost_shipment
        shipping_rates = shipment.shipping_rates
      else
        easypost_rates = ShipmentBuilder.from_package(package).rates.sort_by(&:rate)

        shipping_rates = easypost_rates.map { |rate| build_shipping_rate(rate) }.compact
        shipping_rates.min_by(&:cost)&.selected = true
      end

      shipping_rates
    end

    private

    def build_shipping_rate(rate)
      shipping_method = shipping_method_selector.shipping_method_for(rate)
      return unless shipping_method.available_to_users?

      ::Spree::ShippingRate.new(
        name: "#{rate.carrier} #{rate.service}",
        cost: shipping_rate_calculator.compute(rate),
        easy_post_shipment_id: rate.shipment_id,
        easy_post_rate_id: rate.id,
        shipping_method: shipping_method,
      )
    end

    def shipping_rate_calculator
      @shipping_rate_calculator ||= SolidusEasypost.configuration.shipping_rate_calculator_class.new
    end

    def shipping_method_selector
      @shipping_method_selector ||= SolidusEasypost.configuration.shipping_method_selector_class.new
    end
  end
end
