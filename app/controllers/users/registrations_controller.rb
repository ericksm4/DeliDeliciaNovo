class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_filter :authenticate_user!
  #load_and_authorize_resource
  skip_before_filter :require_no_authentication

    

    def authenticate_account!(opts={})
      opts[:scope] = :account
      warden.authenticate!(opts) # if !devise_controller? || opts.delete(:force)
    end
    
    def sign_up_params
      params.require(:user).permit(:nome, :email, :password, :password_confirmation, :roles_mask)
    end

    def create

    if User.exists?(email: params[:email])
      redirect_to action: 'new', login_existente: 'Login existente'
    else
     
        build_resource(sign_up_params)

        resource_saved = resource.save
        yield resource if block_given?
        if resource_saved
          if resource.active_for_authentication?
             set_flash_message :notice, :signed_up if is_flashing_format?
             #sign_up(resource_name, resource)
             respond_with resource, location: after_sign_in_path_for(resource)
           else
             set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
             expire_data_after_sign_in!
             respond_with resource, location: after_inactive_sign_up_path_for(resource)
           end
         else
           clean_up_passwords resource
           respond_with resource
         end
    end
  end


  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
