class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  #before_filter :authenticate_user!
  before_filter :set_menu

  rescue_from CanCan::AccessDenied do |e|
  	redirect_to '/home?alert=negada'
  end

  def cadastroNewsletter
    cadastro = Admin::CadastroNewsletter.new
    cadastro.email = params[:email]
    cadastro.loja_mais_proxima = params[:loja]

    if cadastro.save
      render :json => cadastro
    end
  end

  protected

  def set_menu
    @menu = Admin::Area.where('exibe_menu = 1 and status = 1').order('ordem')

    @menuFooter1 = @menu.limit(5)
  
    @menuFooter2 = @menu.offset(5).limit(5)
  end

  #devise configs
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :roles_mask, roles: [])}
  end

  def after_sign_out_path_for(resource_or_scope)
    '/login'
  end

  def after_sign_up_path_for(resource)
    '/logout' 
  end

  def after_sign_in_path_for(resource)
	  '/admin/areas'
  end

  def sign_in_and_redirect(resource_or_scope,resource)
    '/logout'
  end

end