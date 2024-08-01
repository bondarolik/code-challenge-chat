class Order < ApplicationRecord
  SHIPPING_METHODS = ['ems', 'courier', 'same_day'].freeze
  STATUS = ['processing'].concat(Fedex::Shipment::STATUS).freeze

  enum status: STATUS.map.with_index { |s, i| [s, i] }.to_h

  belongs_to :product

  after_create :generate_shipment
  after_create :monitor_shipment

  delegate :name, to: :product, prefix: true

  # Generate shipment for the order
  def generate_shipment
    FedexService.new(order: self).call
  end

  def monitor_shipment
    UpdateShippingStatusJob.perform_later(self)
  end
end
