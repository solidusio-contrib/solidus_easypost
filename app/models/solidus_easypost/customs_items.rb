# frozen_string_literal: true

module SolidusEasypost
  class CustomsItems
    attr_reader :order, :items

    def initialize(order)
      @order = order
      @items = []
      build_customs_items
    end

    private

    def build_customs_items
      order.line_items.each do |line_item|
        items << EasyPost::CustomsItem.create(custom_item(line_item))
      end
    end

    def custom_item(line_item)
      # TODO: hs_tariff_number
      {
        id: "cstitem_#{line_item.id}",
        object: 'CustomsItem',
        description: line_item.name[0..255],
        quantity: line_item.quantity,
        amount: line_item.amount.to_f,
        weight: line_item.total_weight,
        code: line_item.variant.sku,
        origin_country: get_stock_location_country(line_item),
        currency: order.currency
      }
    end

    def get_stock_location_country(li)
      inventory_units = li.inventory_units

      shipment_stock_loc = inventory_units.first.try(:shipment).try(:stock_location)

      stock_location = shipment_stock_loc.nil? ? Spree::StockLocation.order_default.first : shipment_stock_loc

      stock_location.country.try(:iso)
    end
  end
end
