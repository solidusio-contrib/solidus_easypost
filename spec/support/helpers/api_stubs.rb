module SolidusEasypost
  module TestHelpers
    module ApiStubs
      def stub_easypost_shipment
        EasyPost::Shipment.class_eval do
          def rates; end

          def tracking_code; end
        end

        easypost_shipment = instance_spy(
          SolidusEasypost.client.shipment,
          id: SecureRandom.hex,
          tracking_code: SecureRandom.hex,
          rates: Array.new(3) { stub_easypost_rate },
        )

        allow(SolidusEasypost.client.shipment).to receive(:retrieve)
          .with(easypost_shipment.id)
          .and_return(easypost_shipment)

        easypost_shipment
      end

      def stub_easypost_rate
        easypost_rate = instance_spy(EasyPost::Rate, id: SecureRandom.hex)

        allow(SolidusEasypost.client.shipment).to receive(:retrieve)
          .with(easypost_rate.id)
          .and_return(easypost_rate)

        easypost_rate
      end
    end
  end
end

RSpec.configure do |config|
  config.include SolidusEasypost::TestHelpers::ApiStubs
end
