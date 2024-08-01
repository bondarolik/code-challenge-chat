require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:order)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:order, customer_name: nil)
  }

  describe "GET #index" do
    it "assigns all orders as @orders" do
      order = Order.create! valid_attributes
      get :index
      expect(assigns(:orders)).to eq([order])
    end
  end

  describe "GET #show" do
    it "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :show, params: { id: order.to_param }
      expect(assigns(:order)).to eq(order)
    end
  end

  describe "GET #new" do
    it "assigns a new order as @order" do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end

      it "assigns a newly created order as @order" do
        post :create, params: { order: valid_attributes }
        expect(assigns(:order)).to be_a(Order)
        expect(assigns(:order)).to be_persisted
      end

      it "redirects to the created order" do
        post :create, params: { order: valid_attributes }
        expect(response).to redirect_to(Order.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved order as @order" do
        post :create, params: { order: invalid_attributes }
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "re-renders the 'new' template" do
        post :create, params: { order: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end
end