# frozen_string_literal: true

RSpec.describe SolidusEasypost::AddressBuilder do
  describe '.from_address', vcr: { cassette_name: 'address_builder/from_address' } do
    it 'builds an address with the correct attributes' do
      address = described_class.from_address(build_stubbed(:address))

      expect(address).to have_attributes(object: 'Address')
      expect(address.name).not_to be_nil
    end
  end

  describe '.from_stock_location', vcr: { cassette_name: 'address_builder/from_stock_location' } do
    it 'builds an address with the correct attributes' do
      address = described_class.from_stock_location(create(:stock_location))

      expect(address).to have_attributes(object: 'Address')
    end
  end
end
