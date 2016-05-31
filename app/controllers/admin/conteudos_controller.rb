class Admin::ConteudosController < ApplicationController
  before_filter :authenticate_user!
 # load_and_authorize_resource
  before_action :set_conteudo, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @conteudos = Admin::Conteudo.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @conteudos = Admin::Conteudo.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end
  
  def self.search(search)  
    if search 
      find(:all, :conditions => ['titulo LIKE ?', "%#{search}%"])
    else  
      find(:all)  
    end  
  end
  
  def show
  end

  def new
    @conteudo = Admin::Conteudo.new
    @conteudos = Admin::Conteudo.all
  end

  def edit
  end
  
  def excluiImagemConteudo
    @conteudo = Admin::Conteudo.find(params[:id])
    @conteudo.remove_imagem_destaque!
    
    respond_to do |format|
      #if @conteudo.update(conteudo_params)
        flash[:notice] = 'Imagem removida com sucesso.'
        format.html { redirect_to action: 'edit'}
      #end
    end
  end
  
  def excluiImagemConteudoBanner
    @conteudo = Admin::Conteudo.find(params[:id])
    @conteudo.remove_imagem_banner!
    
    respond_to do |format|
      #if @conteudo.update(conteudo_params)
        flash[:notice] = 'Imagem removida com sucesso.'
        format.html { redirect_to action: 'edit'}
      #end
    end
  end
  

  def create
    @conteudo = Admin::Conteudo.new(conteudo_params)
    
      respond_to do |format|
        if @conteudo.save
           flash[:notice] = 'Conteudo criado com sucesso.'
          format.html { redirect_to action: 'index' }
          format.json { render action: 'index', location: @conteudo }
        else
          format.html { render action: 'new' }
          format.json { render json: @conteudo.errors, status: :unprocessable_entity }
        end
      end
  end
  
  def update
       respond_to do |format|
         if @conteudo.update(conteudo_params)
            flash[:notice] = 'Conteúdo atualizado com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @conteudo.errors, status: :unprocessable_entity }
         end
       end    
  end
  
  def destroy
    @conteudo.destroy
    respond_to do |format|
      flash[:notice] = 'Conteúdo excluído com sucesso.'
      format.html { redirect_to action: 'index' }
      format.json { head :no_content }
    end
  end
  
  private
    def sort_column  
      params[:sort] || "created_at"  
    end  
    
    def sort_direction  
      params[:direction] || "asc"  
    end  
    
    def set_conteudo
      @conteudo = Admin::Conteudo.find(params[:id])
    end

    def conteudo_params
      params.require(:admin_conteudo).permit(:titulo, :data_inicio, :data_fim, :detaque, :status, :resumo, :conteudo, :imagem_destaque, :imagem_banner, :categoria_id)
    end
end
