RSpec.describe Spree::Carton do
  let(:carton) { create(:carton, tracking: 'EZ1000000001') }
  let(:carton_with_shipping) {
    create(:carton, tracking: 'EZ1000000001', shipping_method: create(:shipping_method, carrier: 'FedEx'))
  }

  let(:easypost_tracker) { instance_double(EasyPost::Models::Tracker) }

  before do
    allow(EasyPost::Services::Tracker).to receive(:create).and_return(easypost_tracker)
  end

  describe '.create' do
    context 'when track_all_cartons is true' do
      before { stub_easypost_config(track_all_cartons: true) }

      it 'tracks the package automatically' do
        VCR.use_cassette('track_all_cartons_automatically') do
          expect(carton.easy_post_tracker_id).to be_present
        end
      end
    end

    context 'when track_all_cartons is false' do
      before { stub_easypost_config(track_all_cartons: false) }

      it 'does not track all packages automatically' do
        expect(create(:carton).easy_post_tracker_id).to be_nil
      end
    end
  end

  describe '#easypost_tracker' do
    context 'when a tracker was already created' do
      it 'returns the existing tracker' do
        VCR.use_cassette('get_existing_tracker') do
          expect(carton.easypost_tracker).to be_present
        end
      end
    end

    context 'when a tracker was not created' do
      it 'creates a new tracker' do
        VCR.use_cassette('create_new_tracker') do
          expect(carton_with_shipping.easypost_tracker).to be_present
        end
      end

      it "sets the tracker's ID on the carton" do
        VCR.use_cassette('track_all_cartons') do
          carton.easypost_tracker
          expect(carton.easy_post_tracker_id).to be_present
        end
      end
    end
  end
end
