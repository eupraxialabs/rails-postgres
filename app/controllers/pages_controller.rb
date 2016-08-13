class PagesController < ApplicationController
  
  skip_before_action :authenticate_user!, :except => [:aboutus, :professionalservices]
#  before_action :authenticate_user!, :except => [:professionalservices]
  skip_before_action :authenticate_user!, :except => [:pricing]
  skip_before_action :authenticate_user!, :except => [:jira]
  skip_before_action :authenticate_user!, :except => [:wso2is]
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

  def jira
    add_breadcrumb "Atlassian Jira", pages_jira_path
  end
  
  def wso2is
    add_breadcrumb "WSO2 Identity Server", pages_wso2is_path
  end

  def info
  end
end
