# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Shipment, :vcr do
  let(:shipment) do
    create :shipment
  end

  describe '#easypost_shipment' do
    subject { shipment.easypost_shipment }

    shared_examples 'an easypost shipment' do
      it 'is an EasyPost::Shipment object' do
        expect(subject).to be_a(EasyPost::Shipment)
      end
    end

    context 'it is a new shipment' do
      it_behaves_like 'an easypost shipment'

      it 'calls the api' do
        expect(EasyPost::Shipment).to receive(:create).with(anything)
        subject
      end
    end

    context 'it is an existing shipment' do
      let(:new_shipment) { create :shipment }

      before do
        ep_id = shipment.easypost_shipment.id
        shipment.shipping_rates.first.update selected: true, easy_post_shipment_id: ep_id
        shipment.instance_variable_set('@ep_shipment', nil)
      end

      it_behaves_like 'an easypost shipment'

      it 'loads the existing shipment' do
        expect(EasyPost::Shipment).to receive(:retrieve).with(anything)
        subject
      end
    end
  end
end
