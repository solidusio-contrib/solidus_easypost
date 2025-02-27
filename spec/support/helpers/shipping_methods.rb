module SolidusEasypost
  module TestHelpers
    module ShippingMethods
      def create_easypost_shipping_methods
        [
          %w[USPS Express],
          %w[USPS GroundAdvantage],
          %w[USPS Priority]
        ].each do |(carrier, service_level)|
          create(
            :shipping_method,
            name: "#{carrier} #{service_level}",
            carrier: carrier,
            service_level: service_level,
            available_to_users: true,
          )
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include SolidusEasypost::TestHelpers::ShippingMethods
end
