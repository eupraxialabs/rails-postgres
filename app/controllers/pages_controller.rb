class PagesController < ApplicationController

  def services
    add_breadcrumb "Services", pages_services_path
  end

  def professionalservices
    add_breadcrumb "Professional Services", pages_professionalservices_path
  end

  def aboutus
    add_breadcrumb "About Us", pages_aboutus_path
  end

  def contactus
    add_breadcrumb "Contact Us", pages_contactus_path
  end

  def pricing
    add_breadcrumb "Pricing", pages_pricing_path
  end

  def info
  end
end
