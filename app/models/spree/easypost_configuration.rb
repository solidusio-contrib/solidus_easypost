# frozen_string_literal: true

class Spree::EasypostConfiguration < Spree::Preferences::Configuration
  preference :ddp_enabled, :boolean, default: false
end
