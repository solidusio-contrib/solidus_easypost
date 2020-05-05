# frozen_string_literal: true

require 'spec_helper'

describe "Customs", :vcr do
  let!(:stock_location) { create(:stock_location) }
  let!(:brazil) { create(:country, iso_name: 'BRAZIL', iso: 'BR', iso3: 'BRA', name: 'Brazil') }
  let(:ship_address) {
    create(:address,
      firstname: 'Allison',
      lastname: 'Reilly',
      address1: 'Barão da Torre, 192',
      address2: 'APT 406',
      zipcode: '22411-000',
      city: 'Rio de Janeiro',
      country: brazil,
      state: nil
    )
  }
  let!(:order) do
    create(:order_with_line_items, line_items_count: 1) do |order|
      order.variants.each { |v| v.update! weight: 10 }
      order.ship_address = ship_address
    end
  end

  it 'is an international shipment' do
    expect(order.shipments.first.international_shipment?).to eq true
  end

  describe '#refresh_shipment_rates' do
    it "can get rates from easy post" do
      order.refresh_shipment_rates
      rates = order.shipments.first.shipping_rates
      expect(rates.all? { |rate| rate.cost.present? }).to be_present
      expect(rates.any?(&:easy_post_shipment_id?)).to be_present
      expect(rates.any?(&:easy_post_rate_id?)).to be_present
    end

    it 'create shipping methods for the rates' do
      order.refresh_shipment_rates
      rates = order.shipments.first.shipping_rates
      expect(rates).to be_all { |rate| rate.shipping_method.present? }
    end
  end

  describe 'easypost shipment' do
    it 'has customs_info' do
      easypost_shipment = order.shipments.first.easypost_shipment

      expect(easypost_shipment.customs_info).not_to be nil
    end
  end
end
