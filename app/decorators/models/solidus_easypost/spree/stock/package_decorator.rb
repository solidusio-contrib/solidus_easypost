# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module Stock
      module PackageDecorator
        def easypost_parcel
          total_weight = contents.sum do |item|
            item.quantity * item.variant.weight
          end

          ::EasyPost::Parcel.create weight: total_weight
        end

        def easypost_address
          address = order.ship_address.easypost_address

          delivery_verifications = address.verifications.try(:delivery)

          return address if delivery_verifications.nil?

          if delivery_verifications.success === false
            delivery_verifications.errors.map(&:message).each do |message|
              order.errors.add(:address, "#{error_label}: #{message}")
            end
          end

          address
        end

        def easypost_shipment
          ::EasyPost::Shipment.create(
            to_address: easypost_address,
            from_address: stock_location.easypost_address,
            parcel: easypost_parcel,
            options: ::Spree::Easypost::Config.ddp_enabled ? { incoterm: 'DDP' } : {}
          )
        end

        def error_label
          'EasyPost address verification'
        end

        ::Spree::Stock::Package.prepend self
      end
    end
  end
end
