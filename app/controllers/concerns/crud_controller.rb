# frozen_string_literal: true

module CrudController
  extend ActiveSupport::Concern

  included do
    before_action :set_resource_class
    before_action :set_resource, only: [:show, :edit, :update, :manage_details]
  end

  def index
    order = params[:order].present? ? params[:order].to_s : "updated_at"
    sort  = params[:sort].present? ? params[:sort].to_s : "desc"

    @resources = @resource_class.all.order(:created_at))
    # @resources = @resources.unscope(:order).order("#{order} #{sort}") if params[:order].present?
  end

  def show; end

  def new
    @resource = resource_class.new
  end

  def edit;  end

  def create
    @resource = resource_class.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'The item was successfully created.' }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource, notice: 'The item was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'The item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def resource_class
    controller_path.classify.delete_prefix("Backoffice::").constantize
  end

  def set_resource_class
    @resource_class = resource_class
  end

  def set_resource
    @resource = @resource_class.find(params[:id])
  end
end
