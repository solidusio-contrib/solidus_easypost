# frozen_string_literal: true

require 'spec_helper'

describe SolidusEasypost::VerifiableAddress, :vcr do
  let(:ship_address) { build(:ship_address) }

  context 'loaded from valid* but not verifiable solidus shipping address' do
    subject { described_class.from_ship_address ship_address }

    it('should not validate') { expect(subject.valid?).to be_falsey }

    describe '#no_easypost_verification_errors' do
      before { subject.validate }

      context 'error response' do
        let(:base_errors) { subject.errors[:base].join }

        it('should have an error') { expect(subject.errors.any?).to be_truthy }

        it 'should mention easypost address verification in the error' do
          expect(base_errors).to match /easypost address verification/i
        end

        it 'should include all address input info in the error response' do
          subject.easypost_params.each do |key, value|
            expect(base_errors).to include key.to_s
            expect(base_errors).to include value.to_s
          end
        end
      end

      it 'should include all address input info in the error response' do
        base_errors = subject.errors[:base].join

        subject.easypost_params.each do |key, value|
          expect(base_errors).to include key.to_s
          expect(base_errors).to include value.to_s
        end
      end
    end
  end

  context 'valid test address from easypost docs' do
    let(:usa) { build :country, iso: 'US' }
    let(:california) { build :state, state_code: 'CA', country: usa }
    let(:ship_address) do
      ::Spree::Address.new(address1: '417 Montgomery Street', city: 'SF', state: california, zipcode: '94104', country: usa)
    end
    subject { described_class.from_ship_address ship_address }

    it 'should validate' do
      expect(subject.valid?).to be_truthy
    end
  end
end
