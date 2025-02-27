# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Shipment do
  let(:easypost_shipment_class) { instance_spy(EasyPost::Services::Shipment) }
  let(:order) { Spree::TestingSupport::OrderWalkthrough.up_to(:complete) }
  let(:shipment) { order.shipments.first }

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
          easypost_config_setup(purchase_labels: true)
          expect(shipment.easypost_shipment).to be_present
        end
      end
    end
  end

  describe '#ship!' do
    context 'when purchase_labels is true' do
      it 'buys the selected rate' do
        VCR.use_cassette('shipment/with_selected_shipping_rates') do
          easypost_config_setup(purchase_labels: true)
          shipment.ship!
          expect(shipment.easypost_shipment).to be_present
          expect(shipment.shipping_rates.where(selected: true).count).to eq(1)
        end
      end
    end

    context 'when purchase_labels is false' do
      it 'does not buy rates automatically' do
        VCR.use_cassette('shipment/disabled_purchase_labels') do
          easypost_config_setup(purchase_labels: false)
          shipment.ship!
          selected_rate = shipment.shipping_rates.where(selected: true).last
          expect(shipment.easypost_shipment).to be_present
          expect(easypost_shipment_class).not_to have_received(:buy).with(selected_rate)
        end
      end
    end
  end
end
