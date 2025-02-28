# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'Postage labels' do
  stub_authorization!

  it "Downloading a shipment's postage label" do
    order = create(:shipped_order) do |o|
      o.shipments.first.selected_shipping_rate.update!(
        easy_post_rate_id: 'rate_test',
        easy_post_shipment_id: 'shp_test',
      )
    end

    visit spree.edit_admin_order_path(order)

    expect(page).to have_content(I18n.t('spree.open_postage_label'))
  end
end
# rubocop:enable RSpec/DescribeClass
