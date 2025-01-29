# frozen_string_literal: true

module SolidusEasypost
  class ShipmentBuilder
    class << self
      def from_package(package, options = {})
        from_address, to_address = address_options(options)
        SolidusEasypost.client.shipment.create(
          to_address: AddressBuilder.from_address(package.order.ship_address, to_address || {}),
          from_address: AddressBuilder.from_stock_location(package.stock_location, from_address || {}),
          parcel: ParcelBuilder.from_package(package),
          options: options
        )
      end

      def from_shipment(shipment, options = {})
        from_address, to_address = address_options(options)
        SolidusEasypost.client.shipment.create(
          to_address: AddressBuilder.from_address(shipment.order.ship_address, to_address || {}),
          from_address: AddressBuilder.from_stock_location(shipment.stock_location, from_address || {}),
          parcel: ParcelBuilder.from_package(shipment.to_package),
          options: options
        )
      end

      def from_return_authorization(return_authorization, options = {})
        from_address, to_address = address_options(options)
        SolidusEasypost.client.shipment.create(
          from_address: AddressBuilder.from_stock_location(return_authorization.stock_location, from_address || {}),
          to_address: AddressBuilder.from_address(return_authorization.order.ship_address, to_address || {}),
          parcel: ParcelBuilder.from_return_authorization(return_authorization),
          is_return: true,
          options: options
        )
      end

      def address_options(options)
        from_address = options.delete(:from_address_options)
        to_address = options.delete(:to_address_options)
        [from_address, to_address]
      end
    end
  end
end
