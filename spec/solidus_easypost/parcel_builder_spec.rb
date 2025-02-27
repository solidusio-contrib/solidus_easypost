# frozen_string_literal: true

RSpec.describe SolidusEasypost::ParcelBuilder do
  let(:parcel_dimension_calculator) { instance_spy(SolidusEasypost.configuration.parcel_dimension_calculator_class) }
  let(:parcel_dimension) { instance_spy(SolidusEasypost::ParcelDimension) }

  before do
    allow(SolidusEasypost.configuration.parcel_dimension_calculator_class)
      .to receive(:new)
      .and_return(parcel_dimension_calculator)

    allow(parcel_dimension_calculator).to receive(:compute).and_return(parcel_dimension)
    allow(parcel_dimension).to receive(:to_h).and_return(dimension_hash)
    allow(EasyPost::Services::Parcel).to receive(:create).and_call_original
  end

  describe '.from_package', vcr: { cassette_name: 'parcel_builder/from_package' } do
    let(:shipment) { create(:shipment) }
    let(:package) { shipment.to_package }

    context 'when there is only the weight set' do
      let(:dimension_hash) { { weight: 10.0 } }

      it 'builds a parcel with the correct attributes' do
        parcel = described_class.from_package(package)

        expect(parcel_dimension_calculator).to have_received(:compute).with(package)
        expect(parcel).to have_attributes(object: 'Parcel', weight: dimension_hash[:weight])
      end
    end

    context 'when all the properties are set' do
      let(:dimension_hash) { { weight: 10.0, height: 2.0, width: 3.0, depth: 4.0 } }

      it 'builds a parcel with the correct attributes' do
        parcel = described_class.from_package(package)

        expect(parcel_dimension_calculator).to have_received(:compute).with(package)
        expect(parcel).to have_attributes(object: 'Parcel', weight: dimension_hash[:weight])
      end
    end
  end

  describe '.from_return_authorization', vcr: { cassette_name: 'parcel_builder/from_return_authorization' } do
    let(:return_item) { create(:return_item) }
    let(:return_authorization) { return_item.return_authorization }

    context 'when there is only the weight set' do
      let(:dimension_hash) { { weight: 10.0 } }

      it 'builds a parcel with the correct attributes' do
        parcel = described_class.from_return_authorization(return_authorization)

        expect(parcel_dimension_calculator).to have_received(:compute).with(return_authorization)
        expect(parcel).to have_attributes(object: 'Parcel', weight: dimension_hash[:weight])
      end
    end

    context 'when all the properties are set' do
      let(:dimension_hash) { { weight: 10.0, height: 2.0, width: 3.0, depth: 4.0 } }

      it 'builds a parcel with the correct attributes' do
        parcel = described_class.from_return_authorization(return_authorization)

        expect(parcel_dimension_calculator).to have_received(:compute).with(return_authorization)
        expect(parcel).to have_attributes(object: 'Parcel', weight: dimension_hash[:weight])
      end
    end
  end
end
