# frozen_string_literal: true

module ShippingMethodHelpers
  FIXTURE_PARAMS = [
    {
      name: "USPS First",
      available_to_users: true,
      admin_name: "USPS First",
      code: "First",
      is_easypost: true
    },
    {
      name: "USPS Priority",
      available_to_users: true,
      admin_name: "USPS Priority",
      code: "Priority",
      is_easypost: true
    },
    {
      name: "USPS ParcelSelect",
      available_to_users: true,
      admin_name: "USPS ParcelSelect",
      code: "ParcelSelect",
      is_easypost: true
    },
    {
      name: "USPS Express",
      available_to_users: true,
      admin_name: "USPS Express",
      code: "Express",
      is_easypost: true
    }
  ].freeze

  def create_shipping_methods
    shipping_category = create :shipping_category
    FIXTURE_PARAMS.each do |params|
      params[:calculator] = Spree::Calculator::Shipping::FlatRate.new
      params[:shipping_categories] = [shipping_category]
      Spree::ShippingMethod.create! params
    end
  end
end

RSpec.configure do |config|
  config.include ShippingMethodHelpers
end
