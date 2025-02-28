# frozen_string_literal: true

RSpec.describe SolidusEasypost::Calculator::WeightDimensionCalculator do
  describe '#compute' do
    subject(:compute) { described_class.new.compute(resource) }

    context 'when a wrong resource is passed' do
      let(:resource) { create(:shipment) }

      it 'raises an unknown partial resource error' do
        expect { compute }.to raise_error(SolidusEasypost::Errors::UnknownPartialResourceError)
      end
    end

    context 'when a Spree::Stock::Package is passed' do
      let(:shipment) { create(:shipment) }
      let(:resource) { shipment.to_package }

      before { allow(SolidusEasypost::ParcelDimension).to receive(:new) }

      it 'build a parcel dimension' do
        compute

        total_weight = resource.contents.sum do |item|
          item.quantity * item.variant.weight
        end

        expect(SolidusEasypost::ParcelDimension).to have_received(:new).with({ weight: total_weight.to_f })
      end
    end

    context 'when a SolidusEasypost::ReturnAuthorization is passed' do
      let(:resource) { SolidusEasypost::ReturnAuthorization.new(create(:return_authorization)) }

      before { allow(SolidusEasypost::ParcelDimension).to receive(:new) }

      it 'build a parcel dimension' do
        compute

        expect(SolidusEasypost::ParcelDimension).to have_received(:new).with({ weight: 0.to_f })
      end
    end
  end
end
