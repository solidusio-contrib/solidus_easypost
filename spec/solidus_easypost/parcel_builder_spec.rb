# frozen_string_literal: true

RSpec.describe SolidusEasypost::ParcelBuilder do
  describe '.from_package', vcr: { cassette_name: 'parcel_builder/from_package' } do
    before { allow(EasyPost::Parcel).to receive(:create).and_call_original }

    let(:shipment) { create(:shipment) }

    context 'when there is only the weight set' do
      it 'builds a parcel with the correct attributes' do
        parcel = described_class.from_package(shipment.to_package)

        expect(EasyPost::Parcel)
          .to have_received(:create)
          .with({ weight: 10.to_f })

        expect(parcel).to have_attributes(object: 'Parcel')
      end
    end

    context 'when all the properties are set' do
      before do
        shipment.inventory_units.each do |inventory_unit|
          inventory_unit.variant.update!(height: 2, width: 3, depth: 4)
        end
      end

      it 'builds a parcel with the correct attributes' do
        parcel = described_class.from_package(shipment.to_package)

        expect(EasyPost::Parcel)
          .to have_received(:create)
          .with({ height: 2.to_f, length: 4.to_f, weight: 10.to_f, width: 3.to_f })

        expect(parcel).to have_attributes(object: 'Parcel')
      end
    end
  end

  describe '.from_return_authorization', vcr: { cassette_name: 'parcel_builder/from_return_authorization' } do
    before { allow(EasyPost::Parcel).to receive(:create).and_call_original }

    let(:return_item) { create(:return_item) }

    context 'when there is only the weight set' do
      it 'builds a parcel with the correct attributes' do
        shipment = described_class.from_return_authorization(return_item.return_authorization)

        expect(EasyPost::Parcel)
          .to have_received(:create)
          .with({ weight: 10.to_f })

        expect(shipment).to have_attributes(object: 'Parcel')
      end
    end

    context 'when all the properties are set' do
      before do
        return_item.inventory_unit.variant.update!(height: 2, width: 3, depth: 4)
      end

      it 'builds a parcel with the correct attributes' do
        shipment = described_class.from_return_authorization(return_item.return_authorization)

        expect(EasyPost::Parcel)
          .to have_received(:create)
          .with({ height: 2.to_f, length: 4.to_f, weight: 10.to_f, width: 3.to_f })

        expect(shipment).to have_attributes(object: 'Parcel')
      end
    end
  end
end
