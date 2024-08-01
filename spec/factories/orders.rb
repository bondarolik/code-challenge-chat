FactoryBot.define do
  factory :order do
    status { 'processing' }
    customer_name { Faker::Name.name }
    adress { Faker::Address.full_address }
    zip_code { Faker::Address.zip_code }
    shipping_method { Order::SHIPPING_METHODS.sample }
    product_id { create(:product).id }

    # trait :completed do
    #   status { 'completed' }
    # end

    # trait :cancelled do
    #   status { 'cancelled' }
    # end
  end
end