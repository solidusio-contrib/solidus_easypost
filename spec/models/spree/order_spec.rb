# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Order, :vcr do
  let!(:order) do
    create(:order_with_line_items, line_items_count: 1) do |order|
      order.variants.each { |v| v.update! weight: 10 }
    end
  end

  before do
    order.refresh_shipment_rates
    Spree::ShippingMethod.update_all(available_to_users: true)
    order.refresh_shipment_rates
  end

  describe '#refresh_shipment_rates' do
    it "can get rates from easy post" do
      rates = order.shipments.first.shipping_rates

      expect(rates.all? { |rate| rate.cost.present? }).to be_present
      expect(rates.any?(&:easy_post_shipment_id?)).to be_present
      expect(rates.any?(&:easy_post_rate_id?)).to be_present
    end

    it 'create shipping methods for the rates' do
      rates = order.shipments.first.shipping_rates
      expect(rates).to be_all { |rate| rate.shipping_method.present? }
    end
  end
end
