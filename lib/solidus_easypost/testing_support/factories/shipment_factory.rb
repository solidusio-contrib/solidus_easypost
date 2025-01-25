# frozen_string_literal: true

FactoryBot.define do
  factory :shipment, class: 'Spree::Shipment' do
    tracking { 'U10000' }
    cost { 100.00 }
    state { 'pending' }
    order
    stock_location

    transient do
      inventory_units { 1 }
    end

    after(:create) do |shipment, e|
      create_list(:inventory_unit, e.inventory_units, shipment: shipment, variant: create(:variant))
    end

    trait :with_easypost do
      transient do
        easypost_shipment_id { 'sh_test' }
        easypost_rate_id { 'rt_test' }
      end

      after(:create) do |shipment, evaluator|
        shipping_method = evaluator.shipping_method || create(:shipping_method, cost: evaluator.cost)
        shipment.shipping_rates.create!(
          shipping_method:,
          cost: evaluator.cost,
          selected: true,
          easy_post_shipment_id: evaluator.easypost_shipment_id,
          easy_post_rate_id: evaluator.easypost_rate_id
        )
      end
    end
  end
end
