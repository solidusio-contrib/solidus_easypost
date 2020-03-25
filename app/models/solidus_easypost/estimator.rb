# frozen_string_literal: true

module SolidusEasypost
  class Estimator
    def shipping_rates(package, frontend_only = true)
      if ::Spree::Easypost::Config.api_enabled
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
        raise ShipmentRequired if package.shipment.nil?
        raise OrderRequired if package.shipment.order.nil?

        rates = calculate_shipping_rates(package)
        rates.select! { |rate| rate.shipping_method.available_to_users? } if frontend_only
        choose_default_shipping_rate(rates)
        ::Spree::Config.shipping_rate_sorter_class.new(rates).sort
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

    def choose_default_shipping_rate(shipping_rates)
      unless shipping_rates.empty?
        default_shipping_rate = ::Spree::Config.shipping_rate_selector_class.new(shipping_rates).find_default
        default_shipping_rate.selected = true
      end
    end

    def calculate_shipping_rates(package)
      tax_calculator_class = ::Spree::Config.shipping_rate_tax_calculator_class
      tax_calculator = tax_calculator_class.new(package.shipment.order)
      shipping_methods(package).map do |shipping_method|
        cost = shipping_method.calculator.compute(package)
        if cost
          rate = shipping_method.shipping_rates.new(
            cost: cost,
            shipment: package.shipment
          )
          tax_calculator.calculate(rate).each do |tax|
            rate.taxes.new(
              amount: tax.amount,
              tax_rate: tax.tax_rate
            )
          end
          rate
        end
      end.compact
    end

    def shipping_methods(package)
      package.shipping_methods
        .available_to_store(package.shipment.order.store)
        .available_for_address(package.shipment.order.ship_address)
        .includes(:calculator)
        .to_a
        .select do |ship_method|
        calculator = ship_method.calculator
        calculator.available?(package) &&
          (calculator.preferences[:currency].blank? ||
           calculator.preferences[:currency] == package.shipment.order.currency)
      end
    end
  end
end
