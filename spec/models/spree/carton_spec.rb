RSpec.describe Spree::Carton do
  describe '.create' do
    context 'when track_all_cartons is true' do
      it 'tracks the package automatically' do
        VCR.use_cassette('track_all_cartons_automatically') do
          allow(EasyPost::Services::Tracker).to receive(:create).and_return(EasyPost::Models::Tracker)
          stub_easypost_config(track_all_cartons: true)

          carton = create(:carton, tracking: 'EZ1000000001')

          expect(carton.easy_post_tracker_id).to be_present
        end
      end
    end

    context 'when track_all_cartons is false' do
      it 'does not track all packages automatically' do
        stub_easypost_config(track_all_cartons: false)

        carton = create(:carton)

        expect(carton.easy_post_tracker_id).to be_nil
      end
    end
  end

  describe '#easypost_tracker' do
    context 'when a tracker was already created' do
      it 'returns the existing tracker' do
        VCR.use_cassette('track_all_cartons_automatically') do
          allow(EasyPost::Services::Tracker).to receive(:create).and_return(EasyPost::Models::Tracker)
          stub_easypost_config(track_all_cartons: true)

          carton = create(:carton, tracking: 'EZ1000000001')

          expect(carton.easy_post_tracker_id).to be_present
        end
      end
    end

    context 'when a tracker was not created' do
      it 'creates a new tracker' do
        VCR.use_cassette('create_new_tracker') do
          carton = create(:carton, tracking: 'EZ1000000001',
            shipping_method: create(:shipping_method, carrier: 'FedEx'))

          expect(carton.easypost_tracker).to be_present
        end
      end

      it "sets the tracker's ID on the carton" do
        VCR.use_cassette('track_all_cartons') do
          carton = create(:carton, tracking: 'EZ1000000001')

          carton.easypost_tracker

          expect(carton.easy_post_tracker_id).to be_present
        end
      end
    end
  end
end
