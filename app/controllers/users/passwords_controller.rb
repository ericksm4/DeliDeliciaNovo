class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  def create
     self.resource = resource_class.send_reset_password_instructions(resource_params)
        if successfully_sent?(resource)
            flash[:password_change] = 'Instruções enviadas para seu e-mail'
            redirect_to '/login'
        else
            flash[:notice] = 'Erro ao enviar instruções enviadas para seu e-mail'
            respond_with(resource)
        end
    end

    protected

    def after_sending_reset_password_instructions_path_for(resource_name)
        root_path
    end
end
