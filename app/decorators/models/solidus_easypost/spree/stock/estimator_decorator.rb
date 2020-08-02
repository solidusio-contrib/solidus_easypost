# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module Stock
      module EstimatorDecorator
        def shipping_rates(package, frontend_only = true)
          if package.shipping_categories.pluck(:use_easypost).any?
            SolidusEasypost::Estimator.new.shipping_rates(package, frontend_only)
          else
            super
          end
        end

        ::Spree::Stock::Estimator.prepend self
      end
    end
  end
end
