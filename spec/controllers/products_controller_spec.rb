# spec/controllers/products_controller_spec.rb
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { create(:product) }

  describe 'GET #index' do
    it 'assigns all products to @products' do
      products = create_list(:product, 3)
      get :index
      expect(assigns(:products)).to match_array(products)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested product to @product' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end

    it 'renders the show template' do
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new product to @product' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new product' do
        expect {
          post :create, params: { product: attributes_for(:product) }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to the new product' do
        post :create, params: { product: attributes_for(:product) }
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new product' do
        expect {
          post :create, params: { product: attributes_for(:product, name: nil) }
        }.to_not change(Product, :count)
      end

      it 're-renders the new template' do
        post :create, params: { product: attributes_for(:product, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested product to @product' do
      get :edit, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end

    it 'renders the edit template' do
      get :edit, params: { id: product.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the product' do
        patch :update, params: { id: product.id, product: { name: 'New Name' } }
        product.reload
        expect(product.name).to eq('New Name')
      end

      it 'redirects to the updated product' do
        patch :update, params: { id: product.id, product: { name: 'New Name' } }
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the product' do
        patch :update, params: { id: product.id, product: { name: nil } }
        product.reload
        expect(product.name).to_not be_nil
      end

      it 're-renders the edit template' do
        patch :update, params: { id: product.id, product: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the product' do
      product
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to products#index' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_path)
    end
  end
end