class Admin::CustomersController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page])
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
  
  def search
    if params[:keyword].present?
      @customers = Customer.where('id LIKE (?)', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @customers = Customer.none
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted, :introduction, :profile_image)
  end
    
end
