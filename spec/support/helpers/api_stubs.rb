module SolidusEasypost
  module TestHelpers
    module ApiStubs
      def stub_easypost_shipment
        ::Spree::Shipment.class_eval do
          def rates; end

          def tracking_code; end
        end

        easypost_shipment = instance_spy(
          ::Spree::Shipment,
          id: SecureRandom.hex,
          tracking_code: SecureRandom.hex,
          rates: Array.new(3) { stub_easypost_rate },
        )

        allow(::EasyPost::Services::Shipment).to receive(:retrieve)
          .with(easypost_shipment.id)
          .and_return(::EasyPost::Models::Shipment)

        easypost_shipment
      end

      def stub_easypost_rate
        easypost_rate = instance_spy(::Spree::ShippingRate, id: SecureRandom.hex)

        allow(::Spree::Shipment).to receive(:retrieve).with(easypost_rate.id).and_return(easypost_rate)

        easypost_rate
      end
    end
  end
end

RSpec.configure do |config|
  config.include SolidusEasypost::TestHelpers::ApiStubs
end
