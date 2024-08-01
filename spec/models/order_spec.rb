# spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it 'is valid with all required attributes' do
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        zip_code: '12345',
        shipping_method: 'ems',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to be_valid
    end

    it 'is invalid without a customer name' do
      order = Order.new(
        adress: '123 Main St',
        zip_code: '12345',
        shipping_method: 'ems',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to_not be_valid
      expect(order.errors[:customer_name]).to include("can't be blank")
    end

    it 'is invalid without an address' do
      order = Order.new(
        customer_name: 'John Doe',
        zip_code: '12345',
        shipping_method: 'ems',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to_not be_valid
      expect(order.errors[:adress]).to include("can't be blank")
    end

    it 'is invalid without a zip code' do
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        shipping_method: 'ems',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to_not be_valid
      expect(order.errors[:zip_code]).to include("can't be blank")
    end

    it 'is invalid without a shipping method' do
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        zip_code: '12345',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to_not be_valid
      expect(order.errors[:shipping_method]).to include("can't be blank")
    end

    it 'is invalid with an invalid shipping method' do
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        zip_code: '12345',
        shipping_method: 'invalid',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to_not be_valid
      expect(order.errors[:shipping_method]).to include("is not included in the list")
    end

    it 'is invalid without a product' do
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        zip_code: '12345',
        shipping_method: 'ems'
      )
      expect(order).to_not be_valid
      expect(order.errors[:product]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to a product' do
      association = Order.reflect_on_association(:product)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'callbacks' do
    it 'generates shipment after create' do
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        zip_code: '12345',
        shipping_method: 'ems',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to receive(:generate_shipment)
      order.save
    end

    it 'monitors shipment after create' do
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        zip_code: '12345',
        shipping_method: 'ems',
        product: Product.new(name: 'Product 1')
      )
      expect(order).to receive(:monitor_shipment)
      order.save
    end
  end

  describe 'delegations' do
    it 'delegates name to product' do
      product = Product.new(name: 'Product 1')
      order = Order.new(
        customer_name: 'John Doe',
        adress: '123 Main St',
        zip_code: '12345',
        shipping_method: 'ems',
        product: product
      )
      expect(order.product_name).to eq('Product 1')
    end
  end
end

