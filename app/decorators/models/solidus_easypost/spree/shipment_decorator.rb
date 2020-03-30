# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module ShipmentDecorator
      def self.prepended(mod)
        mod.state_machine.before_transition(
          to: :shipped,
          do: :buy_easypost_rate,
          if: -> { Solidus::EasyPost::CONFIGS[:purchase_labels?] && ::Spree::Easypost::Config.api_enabled }
        )
      end

      def easypost_shipment
        if selected_easy_post_shipment_id
          @ep_shipment ||= ::EasyPost::Shipment.retrieve(selected_easy_post_shipment_id)
        else
          @ep_shipment = build_easypost_shipment
        end
      end

      def international_shipment?
        address.country != stock_location.country
      end

      private

      def selected_easy_post_rate_id
        selected_shipping_rate.easy_post_rate_id
      end

      def selected_easy_post_shipment_id
        selected_shipping_rate.easy_post_shipment_id
      end

      def build_easypost_shipment
        shipment_hash = {
          to_address: order.ship_address.easypost_address,
          from_address: stock_location.easypost_address,
          parcel: to_package.easypost_parcel,
          options: ::Spree::Easypost::Config.ddp_enabled ? { incoterm: 'DDP' } : {}
        }

        if international_shipment?
          shipment_hash[:customs_info] = SolidusEasypost::CustomsInfo.new(order).info
        end

        ::EasyPost::Shipment.create(shipment_hash)
      end

      def buy_easypost_rate
        rate = easypost_shipment.rates.find do |sr|
          sr.id == selected_easy_post_rate_id
        end

        easypost_shipment.buy(rate)
        self.tracking = easypost_shipment.tracking_code
      end

      ::Spree::Shipment.prepend self
    end
  end
end
