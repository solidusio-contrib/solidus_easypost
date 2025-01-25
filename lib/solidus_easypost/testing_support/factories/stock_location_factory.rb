# frozen_string_literal: true

FactoryBot.define do
  factory :stock_location, class: 'Spree::StockLocation'do
    address1 { '131 S 8th Ave' }
    city { 'Manville' }
    association(:state, name: 'New Jersey', abbr: 'NJ')
    zipcode { '08835' }
    name { 'NY Warehouse' }
  end
end
