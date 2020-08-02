class AddUseEasypostBooleanToShippingCategories < SolidusSupport::Migration[5.1]
  def change
    add_column :spree_shipping_categories, :use_easypost, :boolean, default: true
  end
end
