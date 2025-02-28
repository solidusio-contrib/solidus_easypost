# frozen_string_literal: true

module SolidusEasypost
  class TrackerWebhookHandler
    def self.call(payload)
      return unless payload['description'] == 'tracker.updated'

      carton = ::Spree::Carton.find_by(easy_post_tracker_id: payload['result']['id'])
      return unless carton

      ::SolidusSupport::LegacyEventCompat::Bus.publish :'solidus_easypost.tracker.updated', carton: carton,
        payload: payload
    end
  end
end
