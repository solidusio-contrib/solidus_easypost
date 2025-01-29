RSpec.describe SolidusEasypost::ShippingMethodSelector do
  describe '#shipping_method_for' do
    context 'when a shipping method for the given carrier and service exists' do
      it 'returns the existing shipping method' do
        VCR.use_cassette('shipping_method_selector/returns_shipping_method') do
          stub_easypost_config(purchase_labels: true)
          stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)

          use_easypost_estimator
          create_easypost_shipping_methods

          order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
          shipment = order.shipments.first
          selected_shipping_rate = shipment.shipping_rates.where(selected: true).last
          easypost_rates = shipment.easypost_shipment.rates

          easypost_rate = easypost_rates.select{ |id| id['id'] == selected_shipping_rate.easy_post_rate_id }

          selector = described_class.new
          selected_shipping_method = selector.shipping_method_for(easypost_rate.first)

          expect(selected_shipping_method).to eq(shipment.shipping_method)
        end
      end
    end

    context 'when a shipping method for the given carrier and service does not exist' do
      it 'creates a new shipping method' do
        VCR.use_cassette('shipping_method_selector/new_shipping_method') do
          stub_easypost_config(purchase_labels: true)
          stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)

          use_easypost_estimator
          create_easypost_shipping_methods

          order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
          shipment = order.shipments.first
          selected_shipping_rate = shipment.shipping_rates.where(selected: true).last
          easypost_rates = shipment.easypost_shipment.rates

          easypost_rate = easypost_rates.find{ |id| id['id'] == selected_shipping_rate.easy_post_rate_id }

          selector = described_class.new
          selected_shipping_method = selector.shipping_method_for(easypost_rate)

          expect(selected_shipping_method).to eq(shipment.shipping_method)

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
