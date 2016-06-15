module Spree
  module Stock
    module EstimatorDecorator
      # Added here to provide compatibility moving forward with solidus, which
      # as of v1.3.0 changed the Estimator initialization signature to no longer
      # accept arguments.
      #
      # This is added here to allow a version of the easypost gem to be
      # compatible with both pre and post v1.3 versions and initialize
      # an Estimator in the specs
      def initialize(order=nil)
        return unless order
        @order = order
        @currency = order.currency
      end

      def shipping_rates(package)
        shipment = package.easypost_shipment
        rates = shipment.rates.sort_by { |r| r.rate.to_i }

        if rates.any?
          spree_rates = rates.map do |rate|
            spree_rate = Spree::ShippingRate.new(
              name: "#{ rate.carrier } #{ rate.service }",
              cost: rate.rate,
              easy_post_shipment_id: rate.shipment_id,
              easy_post_rate_id: rate.id,
              shipping_method: find_or_create_shipping_method(rate)
            )

            spree_rate if spree_rate.shipping_method.frontend?
          end.compact

          # Sets cheapest rate to be selected by default
          if spree_rates.any?
            spree_rates.min_by(&:cost).selected = true
          end

          spree_rates
        else
          []
        end
      end

      private

      # Cartons require shipping methods to be present, This will lookup a
      # Shipping method based on the admin(internal)_name. This is not user facing
      # and should not be changed in the admin.
      def find_or_create_shipping_method(rate)
        method_name = "#{ rate.carrier } #{ rate.service }"
        Spree::ShippingMethod.find_or_create_by(admin_name: method_name) do |r|
          r.name = method_name
          r.display_on = :back_end
          r.code = rate.service
          r.calculator = Spree::Calculator::Shipping::FlatRate.create
          r.shipping_categories = [Spree::ShippingCategory.first]
        end
      end
    end
  end
end

Spree::Stock::Estimator.prepend Spree::Stock::EstimatorDecorator
