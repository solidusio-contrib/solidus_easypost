# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Shipment do
  let(:easypost_shipment_class) { instance_spy(EasyPost::Services::Shipment) }

  describe '#easypost_shipment' do
    context 'when no shipping rate was selected' do
      it 'returns nil' do
        shipment = create(:shipment)

        expect(shipment.easypost_shipment).to be_nil
      end
    end

    context 'when a shipping rate was selected' do
      it 'returns the shipment associated with the shipping rate' do
        VCR.use_cassette('shipment/return_easypost_shipment') do
          stub_easypost_config(purchase_labels: true)
          stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)
          use_easypost_estimator
          create_easypost_shipping_methods
          order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
          shipment = order.shipments.first
          expect(shipment.easypost_shipment).to be_present
        end
      end
    end
  end

  describe '#ship!' do
    context 'when purchase_labels is true' do
      it 'buys the selected rate' do
        VCR.use_cassette('shipment/with_selected_shipping_rates') do
          stub_easypost_config(purchase_labels: true)
          stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)
          use_easypost_estimator
          create_easypost_shipping_methods
          order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
          shipment = order.shipments.first
          shipment.ship!
          shipment.shipping_rates.where(selected: true).last
          expect(shipment.easypost_shipment).to be_present
          shipment.easypost_shipment.id
        end
      end
    end

    context 'when purchase_labels is false' do
      it 'does not buy rates automatically' do
        VCR.use_cassette('shipment/disabled_purchase_lables') do
          stub_easypost_config(purchase_labels: false)
          stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)
          use_easypost_estimator
          create_easypost_shipping_methods
          order = Spree::TestingSupport::OrderWalkthrough.up_to(:complete)
          shipment = order.shipments.first
          shipment.ship!
          selected_easypost_rate = shipment.shipping_rates.where(selected: true).last
          expect(shipment.easypost_shipment).to be_present
          expect(easypost_shipment_class).not_to have_received(:buy).with(selected_easypost_rate)
        end
      end
    end
  end
end
