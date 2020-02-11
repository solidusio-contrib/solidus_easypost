# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::EasyPost::ReturnAuthorization, :vcr do
  let(:auth) { described_class.new return_authorization }
  let(:return_authorization) do
    create :return_authorization do |ra|
      ra.return_items << create(:return_item)
    end
  end
  let!(:shipping_method) { create :shipping_method, admin_name: 'USPS Priority' }

  before { create :store }

  describe '#easypost_shipment' do
    subject { auth.easypost_shipment }

    it 'is an EasyPost::Shipment object' do
      expect(subject).to be_a(EasyPost::Shipment)
    end
  end

  describe '#return_label' do
    subject { auth.return_label shipment.rates.first }

    let(:shipment) { auth.easypost_shipment }

    it 'is an EasyPost::PackageLabel object' do
      expect(subject).to be_a(EasyPost::PostageLabel)
    end

    it 'has the correct fields' do
      expect(subject).to have_attributes(
        id: "pl_1a6a46b4c49d45f097665e46aed20bab",
        object: "PostageLabel",
        created_at: "2020-02-11T14:37:51Z",
        updated_at: "2020-02-11T14:37:51Z",
        date_advance: 0,
        integrated_form: "none",
        label_date: "2020-02-11T14:37:51Z",
        label_resolution: 300,
        label_size: "4x6",
        label_type: "default",
        label_url: "https://easypost-files.s3-us-west-2.amazonaws.com/files/postage_label/20200211/3b6726e5085b4f2fb66ef389033543b1.png",
        label_file_type: "image/png"
      )
    end
  end
end
