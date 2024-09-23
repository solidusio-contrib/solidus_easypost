# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_method do
    admin_name { 'Stuff' }
    available_to_users { true }
  end
end
