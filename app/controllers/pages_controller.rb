class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about, :contact, :registration ]

  def home
  end

  def registration
    @user_type = params[:user_type]
  end
  
  def about
  end

  def contact
  end

end
