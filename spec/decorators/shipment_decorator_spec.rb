require 'spec_helper'

RSpec.describe Spree::Shipment do
  let(:shipment) do
    create :shipment do |shipment|
      shipment.update address: create(:address)
    end
  end

  describe '#easypost_shipment' do
    subject { shipment.easypost_shipment }

    shared_examples 'an easypost shipment' do
      it 'is an easypost shipment' do
        VCR.use_cassette('create_easypost_shipment') do
          is_expected.to be_a EasyPost::Shipment
        end
      end
    end

    context 'it is a new shipment' do
      it_behaves_like 'an easypost shipment'

      it 'calls the api', vcr: { cassette_name: 'create_easypost_shipment' } do
        expect(EasyPost::Shipment).to receive(:create).with(anything)
        subject
      end
    end

    context 'it is an existing shipment', vcr: { cassette_name: 'find_easypost_shipment' } do
      before do
        ep_id = shipment.easypost_shipment.id
        shipment.shipping_rates.first.update selected: true, easy_post_shipment_id: ep_id
        shipment.instance_variable_set('@ep_shipment', nil)
      end

      it_behaves_like 'an easypost shipment'

      it 'loads the existing shipment' do
        expect(EasyPost::Shipment).to receive(:retrieve).with(anything).and_call_original
        shipment.shipping_rates(true)
        subject
      end
    end
  end
end
