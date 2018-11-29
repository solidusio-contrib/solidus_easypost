class AddEasyPostPostageLabelUrlToShipment < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_shipments, :easy_post_postage_label_url, :string
  end
end
