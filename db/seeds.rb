Product.create([
  {
    name: 'Exotic Meats Crate',
    price: 99.99,
    stock: 10
  },
  {
    name: 'Smash and Grab Gift Card',
    price: 74.99,
    stock: 10
  },
  {
    name: 'Whiskey Appreciation Crate',
    price: 149.99,
    stock: 10
  },
  {
    name: 'Chef Knife Making Kit',
    price: 179.99,
    stock: 10
  },
  {
    name: 'Ammo Can Speaker Kit',
    price: 149.99,
    stock: 10
  },
  {
    name: 'Smooth Face Mini Crate',
    price: 69.99,
    stock: 10
  }
])

20.times do
  Order.create(
    status: Order::STATUS.sample,
    customer_name: Faker::Name.name,
    adress: Faker::Address.full_address,
    zip_code: Faker::Address.zip_code,
    shipping_method: Order::SHIPPING_METHODS.sample,
    product_id: Product.all.sample.id
  )
end