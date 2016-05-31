class Admin::AcontecesController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_acontece, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @aconteces = Admin::Acontece.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @aconteces = Admin::Acontece.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @acontece = Admin::Acontece.new
    @aconteces = Admin::Acontece.all
  end

  def edit
  end

  def create
    @acontece = Admin::Acontece.new(acontece_params)

    respond_to do |format|
        if @acontece.save
          	flash[:notice] = 'Evento criado com sucesso.'
          	format.html { redirect_to action: 'index'}
          	format.json { render action: 'index', status: :created, location: @acontece }
    	else
          	format.html { render action: 'new' }
          	format.json { render json: @acontece.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @acontece.update(acontece_params)
           flash[:notice] = 'Evento atualizado com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @acontece.errors, status: :unprocessable_entity }
         end
       end   
  end

  def excluiImagemAcontece

    img = Admin::Acontece.find(params[:id])
    img.remove_imagem!

    respond_to do |format|
      if img.update(imagem: '')
        flash[:notice] = 'Evento atualizado com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
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
      params[:sort] || "titulo"  
    end  
    
    def sort_direction  
      params[:direction] || "asc"  
    end  
    
    def set_acontece
      @acontece = Admin::Acontece.find(params[:id])
    end

    def acontece_params
      params.require(:admin_acontece).permit(:titulo, :data_inicio, :data_fim, :imagem, :conteudo)
    end	
end
