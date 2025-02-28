RSpec.describe SolidusEasypost::Configuration do
  describe '#api_key' do
    it 'raises an error if not configured' do
      SolidusEasypost.configuration.api_key = nil
      expect { SolidusEasypost.client }.to raise_error(/API key not configured/)
    end

    it 'does not raise an error if configured' do
      SolidusEasypost.configuration.api_key = 'test_key'
      expect { SolidusEasypost.client }.not_to raise_error
    end
  end
end
