class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  add_breadcrumb "home", :root_path
#  add_breadcrumb "my", :my_path

  def index
    # ...
    #
        add_breadcrumb "index", index_path
  end
end
