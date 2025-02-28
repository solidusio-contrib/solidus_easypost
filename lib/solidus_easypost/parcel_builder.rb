# frozen_string_literal: true

module SolidusEasypost
  class ParcelBuilder
    class << self
      def from_package(package)
        parcel_dimension = SolidusEasypost
                           .configuration
                           .parcel_dimension_calculator_class
                           .new
                           .compute(package)

        SolidusEasypost.client.parcel.create(parcel_dimension.to_h)
      end

      def from_return_authorization(return_authorization)
        parcel_dimension = SolidusEasypost
                           .configuration
                           .parcel_dimension_calculator_class
                           .new
                           .compute(return_authorization)

        SolidusEasypost.client.parcel.create(parcel_dimension.to_h)
      end
    end
  end
end
