RSpec.describe 'Order shipping' do
  context 'with purchase_labels set to true',
    vcr: { cassette_name: 'integration/order_shipping/with_purchase_labels' } do
    it 'buys the rate in EasyPost' do
      stub_easypost_config(purchase_labels: true)
      stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)
      use_easypost_estimator
      create_easypost_shipping_methods

      order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
      shipment = order.shipments.first
      shipment.ship!

      expect(shipment).to be_shipped
      expect(shipment.tracking).to be_present
    end
  end

  context 'with purchase_labels set to false',
    vcr: { cassette_name: 'integration/order_shipping/without_purchase_labels' } do
    it 'does not buy the rate in EasyPost' do
      stub_easypost_config(purchase_labels: false)
      stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)
      use_easypost_estimator
      create_easypost_shipping_methods

      order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
      shipment = order.shipments.first
      shipment.ship!

      expect(shipment).to be_shipped
      expect(shipment.tracking).not_to be_present
    end
  end
end
