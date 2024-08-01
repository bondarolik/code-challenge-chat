class Order < ApplicationRecord
  STATUS = ['processing'].concat(Fedex::STATUS).freeze

  belongs_to :product
end
