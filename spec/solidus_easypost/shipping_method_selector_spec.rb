RSpec.describe SolidusEasypost::ShippingMethodSelector do
  describe '#shipping_method_for' do
    context 'when a shipping method for the given carrier and service exists' do
      it 'returns the existing shipping method' do
        shipping_method = create(:shipping_method, carrier: 'USPS', service_level: 'Express')
        easypost_rate = SolidusEasypost.client.rate.construct_from('carrier' => 'USPS', 'service' => 'Express')

        selector = described_class.new
        selected_shipping_method = selector.shipping_method_for(easypost_rate)

        expect(selected_shipping_method).to eq(shipping_method)
      end
    end

    context 'when a shipping method for the given carrier and service does not exist' do
      it 'creates a new shipping method' do
        shipping_category = create(:shipping_category)
        easypost_rate = SolidusEasypost.client.rate.construct_from('carrier' => 'USPS', 'service' => 'Express')

        selector = described_class.new
        selected_shipping_method = selector.shipping_method_for(easypost_rate)

        expect(selected_shipping_method).to have_attributes(
          name: 'USPS Express',
          carrier: 'USPS',
          service_level: 'Express',
          shipping_categories: [shipping_category],
          available_to_users: false,
        )
      end
    end
  end
end
