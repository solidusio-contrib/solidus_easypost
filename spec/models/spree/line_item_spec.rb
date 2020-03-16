# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::LineItem do
  let!(:line_item) { create(:line_item, quantity: 2) }

  describe '#total_weight' do
    it 'returns quantity * weight' do
      line_item.variant.weight = 3

      expect(line_item.total_weight).to eq 6
    end
  end
end
