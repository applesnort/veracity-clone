class Suppliers::OffersController < ApplicationController
  before_action :find_offer, only: [:show,:update,:generateoffer]

  def show
    # policy_class: app/policies/suppliers/offer_policy#show
    authorize([:suppliers, @offer])
  end



  def update
    @offer.update(offer_params)
    # policy_class: app/policies/suppliers/offer_policy#show
    @offer.update(approved_date: Time.now)
    authorize([:suppliers, @offer])
    redirect_to suppliers_offer_path(@offer)
  end

  def rejected
    # policy_class: app/policies/suppliers/offer_policy#show
    authorize([:suppliers, @offer])
    @offer.rejected
    @offer.update
  end

  def generateoffer
    authorize([:suppliers, @offer])
    @user = current_user
    # policy_class: app/policies/suppliers/offer_policy#show
    html = render_to_string(:generateoffer => "generateoffer.html.erb",:layout => false)
    kit = PDFKit.new(html, :page_size => 'Letter')
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/pages/suppliers/offers/_generateoffer.scss"
    kit.to_pdf
    send_data(kit.to_pdf, :filename => "quote_#{@user.name}.pdf", :type => "application/pdf")
  end


  private

  def find_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.permit(:approved)
  end
end
