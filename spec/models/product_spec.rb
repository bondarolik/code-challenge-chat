# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    product = Product.new(name: 'Sample Product', price: 100.0, stock: 1)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = Product.new(name: nil, price: 100.0)
    expect(product).not_to be_valid
  end

  it 'is not valid without a price' do
    product = Product.new(name: 'Sample Product', price: nil)
    expect(product).not_to be_valid
  end

  it 'is not valid without a stock' do
    product = Product.new(name: 'Sample Product', price: 100.0, stock: nil)
    expect(product).not_to be_valid
  end  
end