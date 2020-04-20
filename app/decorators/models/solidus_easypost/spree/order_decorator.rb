# frozen_string_literal: true

module SolidusEasypost
  module Spree
  	module OrderDecorator

  		def self.prepended(mod)
        mod.state_machine.before_transition(
          to: :delivery,
          do: :ensure_address_verification,
          if: -> { ::Spree::Easypost::Config.api_enabled && ::Spree::Easypost::Config.address_verification_enabled }
        )
      end

  		def ensure_address_verification
	      if errors.details[:address].any?
	      	return false
	      end
	    end

  		::Spree::Order.prepend self
  	end
  end
end