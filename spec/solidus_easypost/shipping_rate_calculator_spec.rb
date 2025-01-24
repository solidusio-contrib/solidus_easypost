RSpec.describe SolidusEasypost::ShippingRateCalculator do
  describe '#compute' do
    it 'returns the amount on the EasyPost rate' do
      easypost_rate = SolidusEasypost.client.rate.construct_from('rate' => 25.0)

      calculator = described_class.new
      computed_rate = calculator.compute(easypost_rate)

      expect(computed_rate).to eq(25.0)
    end
  end
end
