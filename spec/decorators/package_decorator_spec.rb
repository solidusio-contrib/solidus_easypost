require 'spec_helper'

describe Spree::Stock::Package do
  let(:package) { create(:shipment).to_package }

  describe '#easypost_parcel', vcr: { cassette_name: 'create_easypost_parcel' } do
    subject { package.easypost_parcel }

    it { is_expected.to be_a EasyPost::Parcel }

    it 'has the correct attributes' do
      expect(subject).to have_attributes(
        object: 'Parcel',
        weight: 10.0
      )
    end
  end

  describe '#easypost_shipment', vcr: { cassette_name: 'create_easypost_shipment' } do
    subject { package.easypost_shipment }

    it { is_expected.to be_a EasyPost::Shipment }

    it 'calls the api' do
      expect(EasyPost::Shipment).to receive(:create).with(anything)
      subject
    end
  end
end
