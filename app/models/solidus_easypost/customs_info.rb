# frozen_string_literal: true

module SolidusEasypost
  class CustomsInfo
    class InternalTransactionNumberRequired < StandardError; end
    attr_reader :order, :info

    def initialize(order)
      @order = order
      @info = EasyPost::CustomsInfo.create(customs_data)
    end

    def customs_data
      {
        object: 'CustomsInfo',
        eel_pfc: eel_pfc,
        contents_type: 'merchandise',
        contents_explanation: 'merchandise',
        customs_certify: true,
        customs_signer: order.shipping_address.full_name,
        customs_items: SolidusEasypost::CustomsItems.new(order).items,
        non_delivery_option: 'abandon',
        restriction_type: 'none',
        restriction_comments: ''
      }
    end

    private

    def eel_pfc
      if order.total < 2500
        'NOEEI 30.37(a)'
      else
        raise InternalTransactionNumberRequired.new('An ITN is required for any international shipment valued over $2,500 and/or requires an export license unless exemptions apply.')
      end
    end
  end
end
