class AddIsDigitalToStockLocation < SolidusSupport::Migration[4.2]
  def change
    add_column :spree_stock_locations, :is_digital, :boolean, default: false
  end
end
