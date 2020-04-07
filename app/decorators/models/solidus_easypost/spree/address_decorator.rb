# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module EasyPost
      module AddressDecorator
        def easypost_address
          attributes = {
            street1: address1,
            street2: address2,
            city: city,
            zip: zipcode,
            phone: phone
          }

          attributes[:company] = company if respond_to?(:company)
          attributes[:name] = full_name if respond_to?(:full_name)
          attributes[:state] = state ? state.abbr : state_name
          attributes[:country] = country&.iso

          if ::Spree::Easypost::Config.address_verification_enabled

            # The failure of any of these verifications will cause the whole request to fail
            if ::Spree::Easypost::Config.verify_strict_enabled
              attributes[:verify_strict] = ['delivery']
            else
              attributes[:verify] = ['delivery']
            end
          end

          ::EasyPost::Address.create attributes
        end

        ::Spree::Address.prepend self
      end
    end
  end
end
