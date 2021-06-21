# frozen_string_literal: true

module SolidusEasypost
  class AddressBuilder
    class << self
      def from_address(address)
        attributes = {
          street1: address.address1,
          street2: address.address2,
          city: address.city,
          zip: address.zipcode,
          phone: address.phone
        }

        attributes[:company] = address.company if address.respond_to?(:company)
        attributes[:name] = if address.respond_to?(:name)
                              address.name
                            elsif address.respond_to?(:full_name)
                              address.full_name
                            else
                              [address.firstname, address.lastname].join(' ')
                            end
        attributes[:state] = address.state ? address.state.abbr : address.state_name
        attributes[:country] = address.country&.iso

        ::EasyPost::Address.create attributes
      end

      def from_stock_location(stock_location)
        attributes = {
          street1: stock_location.address1,
          street2: stock_location.address2,
          city: stock_location.city,
          zip: stock_location.zipcode,
          phone: stock_location.phone,
          name: stock_location.name,
          company: stock_location.name
        }

        attributes[:state] = stock_location.state ? stock_location.state.abbr : stock_location.state_name
        attributes[:country] = stock_location.country&.iso

        ::EasyPost::Address.create attributes
      end
    end
  end
end
