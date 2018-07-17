class AddEnabledToSpreeStoreShippingMethod < ActiveRecord::Migration[5.2]
  def change
    add_column(:spree_store_shipping_methods, :enabled, :boolean, default: true)
  end
end
