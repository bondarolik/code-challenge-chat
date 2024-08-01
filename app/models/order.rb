require_relative '../../lib/fedex'

class Order < ApplicationRecord
  # STATUS = ['processing'].concat(Fedex::STATUS).freeze

  enum status: STATUS.map { |s| [s, s] }.to_h

  belongs_to :product
end
