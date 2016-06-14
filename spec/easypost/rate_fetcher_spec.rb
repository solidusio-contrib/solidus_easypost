require 'spec_helper'

describe 'Spree::Stock::Estimator customizations' do
  let!(:order) do
    create(:order_with_line_items, line_items_count: 1) do |order|
      order.variants.each { |v| v.update! weight: 10 }
    end
  end

  it "can get rates from easy post", vcr: { cassette_name: 'create_easypost_shipment' } do
    order.refresh_shipment_rates
    rates = order.shipments.first.shipping_rates
    expect(rates.all? { |rate| rate.cost.present? }).to be_present
    expect(rates.all? { |rate| rate.easy_post_shipment_id? }).to be_present
    expect(rates.all? { |rate| rate.easy_post_rate_id? }).to be_present
  end

  it 'create shipping methods for the rates', vcr: { cassette_name: 'create_easypost_shipment' } do
    order.refresh_shipment_rates
    rates = order.shipments.first.shipping_rates
    expect(rates.all? { |rate| rate.shipping_method.present? }).to be_truthy
  end
end
