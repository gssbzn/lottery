# Modified Controller so only Admins can create users
class Admin::AdminsController < Devise::RegistrationsController
  prepend_before_filter :authenticate_scope!
  skip_before_action :require_no_authentication, only: [:new, :create]

  # GET /admin/admins/new
  # GET /admin/admins/new.json
  def new    
    super
  end

  # POST /admin/admins
  # POST /admin/admins.json
  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?

      set_flash_message :notice, 'actioncontroller.admin.created' if is_flashing_format?
      #sign_up(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)

    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  # GET /admin/admins
  # GET /admin/admins.json
  def index
    @admins = Admin.select(:id, :email).order(:email)
  end
end
