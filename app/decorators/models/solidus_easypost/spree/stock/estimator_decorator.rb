# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module Stock
      module EstimatorDecorator

        def shipping_rates(package, frontend_only = true)
          if ::Spree::Easypost::Config.api_enabled && !package.stock_location.is_digital?
            shipment = package.easypost_shipment
            rates = shipment.rates.sort_by { |r| r.rate.to_i }

            shipping_rates = []

            if rates.any?
              rates.each do |rate|
                spree_rate = ::Spree::ShippingRate.new(
                  name: "#{rate.carrier} #{rate.service}",
                  cost: rate.rate,
                  easy_post_shipment_id: rate.shipment_id,
                  easy_post_rate_id: rate.id,
                  shipping_method: find_or_create_shipping_method(rate)
                )

                shipping_rates << spree_rate if spree_rate.shipping_method.available_to_users?
              end

              # Sets cheapest rate to be selected by default
              if shipping_rates.any?
                shipping_rates.min_by(&:cost).selected = true
              end

              shipping_rates
            else
              []
            end
          else
            super
          end
        end

        private

        # Cartons require shipping methods to be present, This will lookup a
        # Shipping method based on the admin(internal)_name. This is not user facing
        # and should not be changed in the admin.
        def find_or_create_shipping_method(rate)
          method_name = "#{rate.carrier} #{rate.service}"
          ::Spree::ShippingMethod.find_or_create_by(admin_name: method_name) do |r|
            r.name = method_name
            r.available_to_users = false
            r.code = rate.service
            r.calculator = ::Spree::Calculator::Shipping::FlatRate.create
            r.shipping_categories = [::Spree::ShippingCategory.first]
          end
        end

        ::Spree::Stock::Estimator.prepend self
      end
    end
  end
end
