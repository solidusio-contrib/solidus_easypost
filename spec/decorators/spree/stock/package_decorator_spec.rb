# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'

# rubocop:disable Metrics/BlockLength
# rubocop:disable Metrics/LineLength
describe Spree::Stock::Package, :vcr do
  let(:package) { create(:shipment).to_package }

  describe '#easypost_parcel' do
    let(:parcel) { package.easypost_parcel }

    it 'is an EasyPost::Parcel object' do
      expect(parcel).to be_a(EasyPost::Parcel)
    end

    it 'has the correct attributes' do
      expect(parcel).to have_attributes(
        object: 'Parcel',
        weight: 10.0
      )
    end
  end

  describe '#easypost_shipment' do
    let(:shipment) { package.easypost_shipment }

    it 'is an EasyPost::Shipment object' do
      expect(shipment).to be_a(EasyPost::Shipment)
    end

    it 'calls the api' do
      expect(EasyPost::Shipment).to receive(:create).with(anything)
      shipment
    end
  end

  # Apologies for the convoluted spec,
  # I didn't want to refactor the package_decorator today.
  describe '#easypost_address' do
    let(:package) { create(:shipment, :invalid_address).to_package }
    let(:order) { instance_double 'order' }
    let(:ship_address) { instance_double 'ship_address' }
    let(:easy_address) { instance_double 'easy address' }
    let(:model_errors) { ActiveModel::Errors.new(order) }
    let(:verifications) { instance_double 'dummy' }

    before do
      ::Spree::Easypost::Config.address_verification_enabled = true

      allow(package).to receive(:order).and_return(order)
      allow(order).to receive(:ship_address).and_return(ship_address)
      allow(ship_address).to receive(:easypost_address).and_return(easy_address)
      allow(order).to receive(:errors).and_return(model_errors)
      allow(easy_address).to receive(:verifications).and_return(verifications)
      package.easypost_address
    end

    context 'with unverifiable address' do
      let(:invalid_address_error) { OpenStruct.new message: 'SoBaD' }
      let(:delivery_verification) { OpenStruct.new success: false, errors: [invalid_address_error] }
      let(:verifications) { OpenStruct.new delivery: delivery_verification }
      let(:addr_err) { order.errors[:address].join }

      it('has model errors') { expect(order.errors).not_to be_empty }
      it('err mentions easypost') { expect(addr_err).to include package.error_label }

      it 'err includes API message' do
        expect(addr_err).to include invalid_address_error.message
      end
    end

    context 'with verifiable address' do
      let(:delivery_verification) { OpenStruct.new success: true }
      let(:verifications) { OpenStruct.new delivery: delivery_verification }
      let(:model_errors) { ActiveModel::Errors.new(order) }

      it('has no errors') { expect(order.errors).to be_empty }
      it('is an AM:Error') { expect(order.errors).to be_a ActiveModel::Errors }
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rubocop:enable Metrics/LineLength
