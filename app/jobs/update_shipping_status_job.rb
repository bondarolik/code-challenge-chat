class UpdateShippingStatusJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    # IMPLEMENT ME
    puts order
    
  end
end
