# frozen_string_literal: true

FactoryBot.modify do
  factory :address do
    address1 { '215 N 7th Ave' }
    city { 'Manville' }
    association(:state, name: 'New Jersey', abbr: 'NJ')
    zipcode { '08835' }
  end
end
