# frozen_string_literal: true

class Spree::EasypostConfiguration < Spree::Preferences::Configuration
  preference :api_enabled, :boolean, default: true
  preference :ddp_enabled, :boolean, default: false
end
