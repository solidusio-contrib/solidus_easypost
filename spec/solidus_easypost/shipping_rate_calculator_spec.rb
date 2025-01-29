RSpec.describe SolidusEasypost::ShippingRateCalculator do
  describe '#compute' do
    it 'returns the amount on the EasyPost rate' do
      VCR.use_cassette('shipping_rate_calculator/returns_amount') do
        stub_easypost_config(purchase_labels: true)
        stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)

        use_easypost_estimator
        create_easypost_shipping_methods

        order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
        shipment = order.shipments.first

        shipment.shipping_rates.where(selected: true).last
        easypost_rates = shipment.easypost_shipment.rates
        calculator = described_class.new
        easypost_rates.each do |rate|
          computed_rate = calculator.compute(rate)
          expect(computed_rate).to eq(rate.rate)
        end
      end
    end
  end
end
