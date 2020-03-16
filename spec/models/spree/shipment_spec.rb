# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Shipment, :vcr do
  let!(:shipment) { order.shipments.first }
  let!(:order) do
    create(:order_with_line_items, line_items_count: 1, ship_address: to) do |order|
      order.variants.each { |v| v.update! weight: 10 }
    end
  end

  let(:to) do
    Spree::Address.create(
      firstname: 'Newt',
      lastname: 'Scamander',
      address1: '200 19th St',
      city: 'Birmingham',
      state: Spree::State.first || create(:state),
      country: Spree::Country.first || create(:country),
      zipcode: 35_203,
      phone: '123456789'
    )
  end

  before do
    create_shipping_methods
    shipment.stock_location.update(
      address1: '2630 Cahaba Rd',
      city: 'Birmingham',
      state: Spree::State.first,
      country: Spree::Country.first,
      zipcode: 35_223,
    )
  end

  it "'buys' a shipping rate after transitioning to ship" do
    shipment.refresh_rates
    shipment.state = 'ready'

    shipment.ship!
    expect(shipment.tracking).to be_present
  end

  describe '#international_shipment?' do
    it 'returns false when shipping nationally' do
      expect(shipment.international_shipment?).to eq false
    end

    it 'returns true when the country doesnt match' do
      shipment.stock_location.country = create(:country)
      expect(shipment.international_shipment?).to eq true
    end
  end
end
