class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  add_breadcrumb "home", :root_path
#  load_and_authorize_resource
#  check_authorization
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end
#  add_breadcrumb "my", :my_path

  def index
    # ...
    #
        add_breadcrumb "index", index_path
  end
end
