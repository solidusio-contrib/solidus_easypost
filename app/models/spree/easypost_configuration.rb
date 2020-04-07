# frozen_string_literal: true

class Spree::EasypostConfiguration < Spree::Preferences::Configuration
  preference :api_enabled, :boolean, default: true
  preference :ddp_enabled, :boolean, default: false
  preference :address_verification_enabled, :boolean, default: false
  preference :verify_strict_enabled, :boolean, default: false
end
