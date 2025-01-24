# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_method, class: 'Spree::ShippingMethod' do
    admin_name { 'Stuff' }
    available_to_users { true }
  end
end
