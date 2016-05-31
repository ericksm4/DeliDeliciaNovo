class Admin::DeliSazonalController < ApplicationController
  
  before_filter :authenticate_user!
  before_action :set_sazonal, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @sazionais = Admin::DeliSazonal.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @sazionais = Admin::DeliSazonal.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @sazonal = Admin::DeliSazonal.new
    @sazionais = Admin::DeliSazonal.all
  end

  def edit
  end

  def create
    @sazonal = Admin::DeliSazonal.new(sazonal_params)

    respond_to do |format|
        if @sazonal.save
          	flash[:notice] = 'Sazonal criado com sucesso.'
          	format.html { redirect_to action: 'index'}
          	format.json { render action: 'index', status: :created, location: @sazonal }
    	else
          	format.html { render action: 'new' }
          	format.json { render json: @sazonal.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @sazonal.update(sazonal_params)
           flash[:notice] = 'Sazonal atualizado com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @sazonal.errors, status: :unprocessable_entity }
         end
       end   
  end

  def excluiImagemSazonal

    img = Admin::DeliSazonal.find(params[:id])
    img.remove_imagem!

    respond_to do |format|
      if img.update(imagem: '')
        flash[:notice] = 'Sazonal atualizado com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
  end

  def destroy
    @sazonal.destroy

    respond_to do |format|
      flash[:notice] = 'Sazonal excluído com sucesso.'
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
    
    def set_sazonal
      @sazonal = Admin::DeliSazonal.find(params[:id])
    end

    def sazonal_params
      params.require(:admin_deli_sazonal).permit(:titulo, :data_inicio, :data_fim, :imagem, :conteudo)
    end
end
