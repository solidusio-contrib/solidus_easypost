# frozen_string_literal: true

require 'spec_helper'

describe SolidusEasypost::CustomsInfo, :vcr do
  let!(:order) { create(:order_with_line_items, line_items_count: 2) }
  let(:customs_info) { SolidusEasypost::CustomsInfo.new(order) }

  describe '#initialize' do
    it 'has order' do
      expect(customs_info.order).to eq(order)
    end
    it 'returns object' do
      expect(customs_info.info).to be_kind_of(Object)
    end
  end

  describe '#items' do
    it 'raises error if order is over 2500' do
      order.total = 3000

      expect{ customs_info }.to raise_error(SolidusEasypost::CustomsInfo::InternalTransactionNumberRequired)
    end
  end
end
