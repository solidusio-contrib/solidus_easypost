# frozen_string_literal: true

FactoryBot.modify do
  factory :shipment do
    transient do
      inventory_units { 1 }
    end

    after(:create) do |shipment, e|
      create_list(:inventory_unit, e.inventory_units, shipment: shipment)
    end

    trait :with_easypost do
      transient do
        easypost_shipment_id { 'sh_test' }
        easypost_rate_id { 'rt_test' }
      end

      after(:create) do |shipment, evaluator|
        create(
          :shipping_rate,
          shipment: shipment,
          selected: true,
          easy_post_shipment_id: evaluator.easypost_shipment_id,
          easy_post_rate_id: evaluator.easypost_rate_id,
        )
      end
    end
  end
end
