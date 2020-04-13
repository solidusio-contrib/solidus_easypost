# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/stock_locations/_form',
  name: 'add is_digital field',
  insert_bottom: '[data-hook="admin_stock_locations_form_fields"]',
  partial: 'spree/admin/stock_locations/is_digital_field'
)
