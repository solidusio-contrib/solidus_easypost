require 'pry'
require 'spec_helper'

RSpec.describe Spree::EasyPost::ReturnAuthorization do
  let(:auth) { described_class.new return_authorization }
  let(:return_authorization) do
    create :return_authorization  do |ra|
      ra.return_items << create(:return_item)
    end
  end
  let!(:shipping_method) { create :shipping_method, admin_name: 'USPS Priority' }

  before { create :store }

  describe '#easypost_shipment', vcr: { cassette_name: 'create_easypost_shipment', allow_playback_repeats: true } do
    subject { auth.easypost_shipment }
    it { is_expected.to be_a EasyPost::Shipment }
  end

  describe '#return_label', vcr: { cassette_name: 'create_return_label' } do
    subject { auth.return_label shipment.rates.first }
    let(:shipment) { auth.easypost_shipment }

    it { is_expected.to be_a EasyPost::PostageLabel }
    it 'has the correct fields' do
      expect(subject).to have_attributes(
        {
          :id=>"pl_69e2d1309a0e4b84aa2c1397b70153db",
          :object=>"PostageLabel",
          :created_at=>"2016-05-09T18:57:00Z",
          :updated_at=>"2016-05-09T18:57:01Z",
          :date_advance=>0,
          :integrated_form=>"none",
          :label_date=>"2016-05-09T18:56:58Z",
          :label_resolution=>300,
          :label_size=>"4x6",
          :label_type=>"default",
          :label_file_type=>"image/png",
          :label_url=>"https://easypost-files.s3-us-west-2.amazonaws.com/files/postage_label/20160509/3462b1698d7248e7aea1b9cae4bd980d.png",
          :label_pdf_url=>nil,
          :label_zpl_url=>nil,
          :label_epl2_url=>nil
        }
      )
    end
  end
end
