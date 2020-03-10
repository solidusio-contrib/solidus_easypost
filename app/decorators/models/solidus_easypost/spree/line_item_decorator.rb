# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module LineItemDecorator
      def total_weight
        quantity * variant.weight
      end

      ::Spree::LineItem.prepend self
    end
  end
end
