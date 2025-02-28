RSpec.describe 'Checkout' do
  it 'retrieves the rates from EasyPost', vcr: { cassette_name: 'integration/checkout' } do
    easypost_config_setup(purchase_labels: true)

    order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
    shipment = order.shipments.first
    shipment.ship!

    # Verify that the shipment's shipping rates are correctly updated with the new charges,
    # carrier service information, and that a tracking code is assigned.
    expect(order.state).to eq('complete')
    expect(shipment.shipping_rates).to contain_exactly(have_attributes(
      selected: true,
      cost: 0.5e1,
      name: 'USPS GroundAdvantage',
      easy_post_shipment_id: /shp_/,
      easy_post_rate_id: /rate_/,
    ), have_attributes(
      selected: false,
      cost: 0.654e1,
      name: 'USPS Priority',
      easy_post_shipment_id: /shp_/,
      easy_post_rate_id: /rate_/,
    ), have_attributes(
      selected: false,
      cost: 0.276e2,
      name: 'USPS Express',
      easy_post_shipment_id: /shp_/,
      easy_post_rate_id: /rate_/,
    ))
    expect(shipment.tracking).to be_present
  end
end
