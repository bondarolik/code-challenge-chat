class Order < ApplicationRecord
  SHIPPING_METHODS = ['ems', 'courier', 'same_day'].freeze
  STATUS = ['processing'].concat(Fedex::Shipment::STATUS).freeze

  enum status: STATUS.map.with_index { |s, i| [s, i] }.to_h

  belongs_to :product

  validates :customer_name, presence: true
  validates :adress, presence: true
  validates :zip_code, presence: true
  validates :shipping_method, presence: true, inclusion: { in: SHIPPING_METHODS }
  validates :product, presence: true

  after_create :generate_shipment
  after_create :monitor_shipment

  scope :search, ->(query) do
    joins(:product).where('LOWER(customer_name) LIKE :query OR LOWER(adress) LIKE :query OR LOWER(zip_code) LIKE :query OR LOWER(shipping_method) LIKE :query OR LOWER(products.name) LIKE :query', query: "%#{query.downcase}%")
  end

  delegate :name, to: :product, prefix: true

  # Generate shipment for the order
  def generate_shipment
    FedexService.new(order: self).call
  end

  def monitor_shipment
    UpdateShippingStatusJob.perform_later(self)
  end
end
