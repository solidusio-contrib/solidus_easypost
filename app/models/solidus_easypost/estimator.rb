module SolidusEasypost
  class Estimator
    def shipping_rates(package, frontend_only = true)
      shipment = package.easypost_shipment
      store = package.order.store
      rates = shipment.rates.sort_by { |r| r.rate.to_i }

      shipping_rates = []

      if rates.any?
        rates.each do |rate|
          shipping_method = find_or_create_shipping_method(rate, store)

          spree_rate = Spree::ShippingRate.new(
            name: "#{ rate.carrier } #{ rate.service }",
            cost: rate.rate,
            easy_post_shipment_id: rate.shipment_id,
            easy_post_rate_id: rate.id,
            shipping_method: shipping_method
          )

          if store.store_shipping_methods.find_by(shipping_method: shipping_method)&.enabled?
            shipping_rates << spree_rate
          elsif spree_rate.shipping_method.available_to_users?
            shipping_rates << spree_rate
          end
        end

        # Sets cheapest rate to be selected by default
        if shipping_rates.any?
          shipping_rates.min_by(&:cost).selected = true
        end

        shipping_rates
      else
        []
      end
    end

    private

    # Cartons require shipping methods to be present, This will lookup a
    # Shipping method based on the admin(internal)_name. This is not user facing
    # and should not be changed in the admin.
    def find_or_create_shipping_method(rate, store)
      admin_name = "#{ rate.carrier } - #{ rate.carrier_account_id }"
      sm = Spree::ShippingMethod.find_or_create_by(admin_name: admin_name) do |r|
        r.name = admin_name
        r.display_on = 'back_end'
        r.code = admin_name
        r.carrier = rate.carrier
        r.available_to_users = false
        r.available_to_users = false
        r.calculator = Spree::Calculator::Shipping::FlatRate.create
        r.shipping_categories = [Spree::ShippingCategory.first]
      end

      begin
        store.shipping_methods << sm
      rescue ActiveRecord::RecordNotUnique => e
        # do nothing, this is to prevent duplicates
      end

      sm
    end
  end
end
