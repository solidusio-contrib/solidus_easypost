RSpec.describe Spree::Admin::PostageLabelsController do
  stub_authorization!

  let(:order) { Spree::TestingSupport::OrderWalkthrough.up_to(:complete) }
  let(:shipment) { order.shipments.first }

  let!(:easypost_setup) do
    easypost_config_setup(true)
  end

  before do
    order
    shipment.ship!
  end

  describe "GET #show" do
    it 'redirects to the postage label', vcr: { cassette_name: 'postage_labels/show' } do
      get :show, params: { shipment_id: shipment.number }

      expect(response).to redirect_to(response.location)
      expect(response.location).to start_with("https://easypost-files.s3.us-west-2.amazonaws.com/files/postage_label")
    end
  end
end
