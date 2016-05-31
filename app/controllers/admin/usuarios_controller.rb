class Admin::UsuariosController < ApplicationController
  before_filter :authenticate_user!

  #before_action :set_conteudo, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
        @usuarios = User.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @usuarios = User.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def delete
  	User.where('id = ?', params[:id]).destroy_all
  	render :json => @vazio
  end

  def edit
  	if params[:user_id]
  		User.find(params[:user_id]).update(:nome => params[:nome], :email => params[:email])
  		redirect_to '/admin/usuarios'
  	end
  end

  private
    def sort_column
      params[:sort] || "nome"
    end

    def sort_direction
      params[:direction] || "asc"
    end
end
