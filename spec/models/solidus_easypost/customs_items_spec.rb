# frozen_string_literal: true

require 'spec_helper'

describe SolidusEasypost::CustomsItems, :vcr do
  let!(:order) { create(:order_with_line_items, line_items_count: 2) }
  let(:customs_items) { SolidusEasypost::CustomsItems.new(order) }

  describe '#initialize' do
    it 'has order' do
      expect(customs_items.order).to eq(order)
    end
    it 'has lines be an array' do
      expect(customs_items.items).to be_kind_of(Array)
    end
    it 'items should be a length of 2' do
      expect(customs_items.items.length).to eq(2)
    end
  end
end
