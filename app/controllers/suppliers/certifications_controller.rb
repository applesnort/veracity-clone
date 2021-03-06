class Suppliers::CertificationsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:new, :edit]
  before_action :find_certification, only: [:edit,:update]


  def new
    @certification = Certification.new
    @product = Product.find(params[:product_id])
    authorize([:suppliers, @certification])
  end

  def create
    @certification = Certification.new(certification_params)
    @product = Product.find(params[:certification][:product_id])
    @certification.products << @product
    authorize([:suppliers, @certification])
    if @certification.save
      redirect_to suppliers_dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @certification.update(certification_params)
      redirect_to products_path
    else
      render :edit
    end
  end



  private

  def find_certification
    @certification = Certification.find(params[:id])
  end

  def certification_params
    params.require(:certification).permit(:number, :category, :listing_number, :code, :start_date, :expired_date, :authority, photos: [])
  end
end
