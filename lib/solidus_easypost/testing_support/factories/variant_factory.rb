# frozen_string_literal: true

FactoryBot.define do
  factory :variant, class: 'Spree::Variant' do
    weight { 10.0 }
  end
end
