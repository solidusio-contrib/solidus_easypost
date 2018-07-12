class AddEasyPostPublicTrackingUrlToShipment < SolidusSupport::Migration[5.2]
  def change
    add_column :spree_shipments, :easy_post_public_tracking_url, :string
  end
end
