class AddIsEasypostToShippingMethods < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_shipping_methods, :is_easypost, :boolean
    change_column_default :spree_shipping_methods, :is_easypost, false
  end
end
