class SuppliersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :find_supplier, only: [:show,:edit,:update]

  def show
    authorize @supplier
  end

  def edit
    authorize @supplier
  end

  def update
    authorize @supplier
    if @supplier.update(supplier_params)
      puts @supplier.name_match?
      puts @supplier.fda_profile_match?
      if @supplier.name_match? && @supplier.fda_profile_match?
        Verification.create!(
          supplier: @supplier,
          registration_completion: true
        )
        puts "#" * 60
        puts Verification.last
        puts "#" * 60
        redirect_to suppliers_dashboard_path
      else
        raise
        # render :edit
      end
    else
      render :edit
    end
  end


  private

  def supplier_params
    params.require(:supplier).permit(:name, :location, :industry, :delivery_terms, :payment_terms, :fei_number, :nearest_port, :established)
  end

  def find_supplier
    @supplier = Supplier.find(params[:id])
  end
end
