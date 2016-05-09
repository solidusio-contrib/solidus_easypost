require 'pry'
require 'spec_helper'

RSpec.describe Spree::Stock::Estimator do
  let(:estimator) { described_class.new shipment.order }
  let!(:shipment) { create :shipment }
  let(:package) { shipment.to_package }

  describe '#shipping_rates', vcr: { cassette_name: 'create_easypost_shipment' } do
    subject { estimator.shipping_rates package }

    context 'rates are found' do
      context 'shipping methods exist' do
        before { create_shipping_methods }

        it 'create no new shipping methods' do
          expect { subject }.to_not change { Spree::ShippingMethod.count }
        end

        context 'shipping methods are front end visible' do
          let(:rate_names) { ["USPS Express", "USPS First", "USPS ParcelSelect", "USPS Priority"] }
          let(:rate_costs) { [3.35, 5.75, 5.95, 20.66] }

          it 'has the correct names' do
            names = subject.map(&:name).sort
            expect(names).to eq rate_names
          end

          it 'has the correct costs' do
            costs = subject.map(&:cost).sort
            expect(costs).to eq rate_costs
          end
        end

        context 'shipping methods are not front end visible' do
          before { Spree::ShippingMethod.update_all display_on: :back_end }
          it { is_expected.to be_empty }
        end
      end

      context 'shipping methods dont exist' do
        it { is_expected.to be_empty } # new shipping methods are backend only

        it 'creates new shipping methods' do
          expect { subject }.to change { Spree::ShippingMethod.count }.by 4
        end
      end
    end

    context 'no rates are found' do
      let(:package) do
        instance_double(Spree::Stock::Package, easypost_shipment: fake_shipment)
      end

      let(:fake_shipment) do
        double(EasyPost::Shipment, rates: [])
      end

      it { is_expected.to be_empty }

      it 'create no new shipping methods' do
        expect { subject }.to_not change { Spree::ShippingMethod.count }
      end
    end
  end
end
