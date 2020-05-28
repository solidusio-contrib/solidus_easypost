module SolidusEasypost
  class ConfigChecker
    attr_reader :results

    def initialize
      results = {}
      check_all!
    end

    def check_all!
      check_shipping_methods
      check_stock_locations
      check_variants
    end

    def check_shipping_methods
      # confirm is_easypost field exists
      # coerce nils to false
      # check existing methods against known method names
      # make the EP-matched names is_easypost: true
    end

    def check_stock_locations
      # make sure they have addresses
      locs = ::Spree::StockLocation
      # validate them exactly once, with a timestamp maybe?
    end

    def check_variants
      # make sure they have weights
      exceptions = ::Spree::Variant.where(weight: nil)
      results[:weightless_variants] = exceptions.pluck(:sku)
    end
  end
end