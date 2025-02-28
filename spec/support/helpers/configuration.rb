module SolidusEasypost
  module TestHelpers
    module Configuration
      def stub_easypost_config(values)
        allow(SolidusEasypost.configuration).to receive_messages(values)
      end

      def easypost_config_setup(purchase_labels: false)
        stub_easypost_config(purchase_labels: purchase_labels) if purchase_labels
        stub_spree_preferences(require_payment_to_ship: false, track_inventory_levels: false)
        use_easypost_estimator
        create_easypost_shipping_methods
      end

      def use_easypost_estimator
        stock_configuration = ::Spree::Core::StockConfiguration.new.tap do |stock_config|
          stock_config.estimator_class = 'SolidusEasypost::Estimator'
        end

        if ::Spree.solidus_gem_version >= Gem::Version.new('2.9.0')
          stub_spree_preferences(stock: stock_configuration)
        else
          # rubocop:disable RSpec/AnyInstance
          allow_any_instance_of(::Spree::AppConfiguration).to receive(:stock)
            .and_return(stock_configuration)
          # rubocop:enable RSpec/AnyInstance
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include SolidusEasypost::TestHelpers::Configuration
end
