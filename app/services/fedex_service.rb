require_relative '../../lib/fedex'

class FedexService < ApplicationService
  def initialize(order:)
    @order = order
  end

  def call
    # Call FedEx API
    shipment = Fedex::Shipment.create
    
  end
end