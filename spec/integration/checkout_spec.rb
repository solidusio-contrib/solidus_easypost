RSpec.describe 'Checkout' do
  it 'retrieves the rates from EasyPost', vcr: { cassette_name: 'integration/checkout' } do
    stub_easypost_config(purchase_labels: true)
    stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)
    use_easypost_estimator
    create_easypost_shipping_methods

    order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
    shipment = order.shipments.first
    shipment.ship!

    expect(order.state).to eq('complete')
    expect(shipment.shipping_rates).to contain_exactly(have_attributes(
      selected: true,
      cost: 0.393e1,
      name: 'USPS First',
      easy_post_shipment_id: /shp_/,
      easy_post_rate_id: /rate_/,
    ), have_attributes(
      selected: false,
      cost: 0.692e1,
      name: 'USPS ParcelSelect',
      easy_post_shipment_id: /shp_/,
      easy_post_rate_id: /rate_/,
    ), have_attributes(
      selected: false,
      cost: 0.702e1,
      name: 'USPS Priority',
      easy_post_shipment_id: /shp_/,
      easy_post_rate_id: /rate_/,
    ), have_attributes(
      selected: false,
      cost: 0.23e2,
      name: 'USPS Express',
      easy_post_shipment_id: /shp_/,
      easy_post_rate_id: /rate_/,
    ))

    expect(shipment.tracking).to be_present
  end
end
