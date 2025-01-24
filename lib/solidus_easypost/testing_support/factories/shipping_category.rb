# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_category, class: 'Spree::ShippingCategory' do
    name { 'normal' }
  end
end
