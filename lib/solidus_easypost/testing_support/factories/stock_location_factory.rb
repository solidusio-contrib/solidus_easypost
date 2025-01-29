# frozen_string_literal: true

FactoryBot.modify do
  factory :stock_location do
    address1 { '131 S 8th Ave' }
    city { 'Manville' }
    association(:state, name: 'New Jersey', abbr: 'NJ')
    zipcode { '08835' }
  end
end
