# frozen_string_literal: true

require 'forwardable'

module SolidusEasypost
  class ReturnAuthorization
    extend Forwardable

    attr_reader :return_authorization

    def_delegators :@return_authorization, :stock_location, :order, :inventory_units

    def initialize(return_authorization)
      @return_authorization = return_authorization
    end

    def easypost_shipment
      @easypost_shipment ||= ShipmentBuilder.from_return_authorization(self)
    end

    def return_label(rate)
      # If a tracking code already exists, postage has been purchased—no need to buy another label.
      return if @easypost_shipment.postage_label

      # NOTE: The API structure for purchasing labels has changed.
      # This method has been updated to use the new syntax.
      # For more details on the updated API endpoints and payloads, please refer to:
      # https://docs.easypost.com/docs/shipments#buy-a-shipment
      return_authorization_easypost_shipment = SolidusEasypost.client.shipment.buy(
        @easypost_shipment.id,
        rate: { id: rate.id }
      )

      return_authorization_easypost_shipment.postage_label
    end
  end
end
