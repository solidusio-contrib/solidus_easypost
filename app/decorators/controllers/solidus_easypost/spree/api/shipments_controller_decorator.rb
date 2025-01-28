# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module Api
      module ShipmentsControllerDecorator
        def estimated_rates
          @shipping_rates = @shipment.shipping_rates
        end

        def select_shipping_method
          authorize! :update, @shipment
          shipping_method = ::Spree::ShippingMethod.find(params.require(:shipping_method_id))
          @shipment.select_shipping_method(shipping_method)
          @order.recalculate
          respond_with(@shipment, default_template: :show)
        end

        ::Spree::Api::ShipmentsController.prepend self
      end
    end
  end
end
