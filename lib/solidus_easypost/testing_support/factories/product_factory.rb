# frozen_string_literal: true

FactoryBot.define do
  factory :base_product, class: 'Spree::Product' do
    weight { 10.0 }
  end
end
