class AddUniqueIndexToSpreeStoreShippingMethods < ActiveRecord::Migration[5.2]
  def change
    add_index :spree_store_shipping_methods, [:store_id, :shipping_method_id], unique: true, name: 'unique_idx_on_store_and_shipping_method'
  end
end
