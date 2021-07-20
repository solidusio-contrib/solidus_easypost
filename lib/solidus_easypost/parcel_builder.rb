# frozen_string_literal: true

module SolidusEasypost
  class ParcelBuilder
    class << self
      def from_package(package)
        params = {
          weight: package_property_total(property: :weight, package: package)
        }

        total_width = package_property_total(property: :width, package: package)
        total_height = package_property_total(property: :height, package: package)
        total_depth = package_property_total(property: :depth, package: package)

        params[:width] = total_width unless total_width.zero?
        params[:height] = total_height unless total_height.zero?
        params[:length] = total_depth unless total_depth.zero?

        ::EasyPost::Parcel.create(**params)
      end

      def from_return_authorization(return_authorization)
        params = {
          weight: return_authorization.inventory_units.joins(:variant).sum(:weight)
        }

        total_width = return_authorization.inventory_units.joins(:variant).sum(:width)
        total_height = return_authorization.inventory_units.joins(:variant).sum(:height)
        total_depth = return_authorization.inventory_units.joins(:variant).sum(:depth)

        params[:width] = total_width unless total_width.zero?
        params[:height] = total_height unless total_height.zero?
        params[:length] = total_depth unless total_depth.zero?

        ::EasyPost::Parcel.create(**params)
      end

      private

      def package_property_total(property:, package:)
        package.contents.sum do |item|
          item.quantity * (item.variant.public_send(property) || 0)
        end
      end
    end
  end
end
