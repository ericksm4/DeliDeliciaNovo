class Admin::ListagemAcontecesController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_acontece, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @aconteces = Admin::ListagemAcontece.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @aconteces = Admin::ListagemAcontece.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def edit
  end
  
  def destroy
    @acontece.destroy

    respond_to do |format|
      flash[:notice] = 'Evento excluído com sucesso.'
      format.html { redirect_to action: 'index'}
      format.json { head :no_content }
    end
  end

  private
    def sort_column  
      params[:sort] || "nome"  
    end  
    
    def sort_direction  
      params[:direction] || "asc"  
    end  
    
    def set_acontece
      @acontece = Admin::ListagemAcontece.find(params[:id])
    end
end
