RSpec.describe SolidusEasypost::ShippingRateCalculator do
  describe '#compute' do
    let(:order) { Spree::TestingSupport::OrderWalkthrough.up_to(:complete) }
    let(:shipment) { order.shipments.first }
    let(:easypost_rates) { shipment.easypost_shipment.rates }
    let(:calculator) { described_class.new }

    before do
      easypost_config_setup(purchase_labels: true)
    end

    it 'returns the amount on the EasyPost rate' do
      VCR.use_cassette('shipping_rate_calculator/returns_amount') do
        easypost_rates.each do |rate|
          expect(rate).to be_an_instance_of(EasyPost::Models::Rate)
          expect(calculator.compute(rate)).to eq(rate.rate)
        end
      end
    end
  end
end
