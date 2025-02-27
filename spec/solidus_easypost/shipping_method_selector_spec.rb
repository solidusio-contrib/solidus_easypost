RSpec.describe SolidusEasypost::ShippingMethodSelector do
  let(:order) { Spree::TestingSupport::OrderWalkthrough.up_to(:complete) }
  let(:shipment) { order.shipments.first }
  let(:selected_shipping_rate) { shipment.shipping_rates.find_by(selected: true) }
  let(:easypost_rates) { shipment.easypost_shipment.rates }
  let(:easypost_rate) { easypost_rates.find { |rate| rate['id'] == selected_shipping_rate.easy_post_rate_id } }
  let(:selector) { described_class.new }

  before do
    easypost_config_setup(true)
  end

  describe '#shipping_method_for' do
    context 'when a shipping method for the given carrier and service exists' do
      it 'returns the existing shipping method' do
        VCR.use_cassette('shipping_method_selector/returns_shipping_method') do
          expect(selector.shipping_method_for(easypost_rate)).to eq(shipment.shipping_method)
        end
      end
    end

    context 'when a shipping method for the given carrier and service does not exist' do
      it 'creates a new shipping method' do
        VCR.use_cassette('shipping_method_selector/new_shipping_method') do
          selected_shipping_method = selector.shipping_method_for(easypost_rate)

          expect(selected_shipping_method).to have_attributes(
            carrier: easypost_rate.carrier,
            service_level: easypost_rate.service
          )
          expect(selected_shipping_method.shipping_categories).to be_present
        end
      end
    end
  end
end
