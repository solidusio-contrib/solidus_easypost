# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module CartonDecorator
      def self.prepended(base)
        base.after_create :track_via_easypost
      end

      def easypost_tracker
        return @easypost_tracker if @easypost_tracker

        if easy_post_tracker_id.present?
          @easypost_tracker = SolidusEasypost.client.tracker.retrieve(easy_post_tracker_id)
        else
          @easypost_tracker = SolidusEasypost.client.tracker.create(
            tracking_code: tracking,
            carrier: shipping_method.carrier,
          )

          update!(easy_post_tracker_id: @easypost_tracker.id)
        end

        @easypost_tracker
      end

      private

      def track_via_easypost
        return unless SolidusEasypost.configuration.track_all_cartons

        easypost_tracker
      end

      ::Spree::Carton.prepend self
    end
  end
end
