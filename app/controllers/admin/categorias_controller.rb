class Admin::CategoriasController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource
  before_action :set_categoria, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @categorias = Admin::Categoria.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
    else
      @categorias = Admin::Categoria.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
    end
  end

  def categorias_select
       area = Admin::Area.find(params[:area_id])
       @categorias = area.categorias.find(:all, :conditions => ['id <> ?', params[:categoria_id]]).map{|c| [c.nome, c.id]}.insert(0, "Sem categoria pai")
  end
  
  
  def show
  end

  def new
    @categoria = Admin::Categoria.new
    @categorias = Admin::Categoria.all
  end


  def edit
    @categorias = Admin::Categoria.select("id, nome").where("id <> ?", params[:id])
  end
  
  def excluiImagemCategoria
    @categoria = Admin::Categoria.find(params[:id])
    @categoria.remove_imagem!
    @categoria.imagem_url = ''
    @categoria.imagem_target_link = ''
    
    respond_to do |format|
      if @categoria.update(params[:categoria])
        flash[:notice] = 'Categoria atualizada com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
  end
  
  
  def create
    @categoria = Admin::Categoria.new(categoria_params)
      respond_to do |format|
        if @categoria.save
          atualizaOrdem(@categoria.id, @categoria.ordem)
          flash[:notice] = 'Categoria criada com sucesso.'
          format.html { redirect_to action: 'index'}
          format.json { render action: 'index', status: :created, location: @categoria }
        else
          format.html { render action: 'new' }
          format.json { render json: @categoria.errors, status: :unprocessable_entity }
        end
      end
  end
  

  def update
      respond_to do |format|
         if @categoria.update(categoria_params)
          atualizaOrdem(@categoria.id, @categoria.ordem)
           flash[:notice] = 'Categoria atualizada com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @categoria.errors, status: :unprocessable_entity }
         end
       end
  end
  
  def atualizaOrdem id_categoria, ordem_categoria
    update_categoria = Admin::Categoria.where("id <> ? AND (ordem = ?)", id_categoria, ordem_categoria).first
    unless update_categoria.blank?
      update_categoria.update(ordem: update_categoria.ordem + 1)
      atualizaOrdem(update_categoria.id, update_categoria.ordem)
    end
  end 

  def destroy
    if @categoria.destroy       
      respond_to do |format|
        flash[:notice] = 'Categoria excluída com sucesso.'
        format.html { redirect_to action: 'index'}
        format.json { head :no_content }
      end
    else      
      if Admin::Categoria.exists?(categoria_id: @categoria.id) 
        respond_to do |format|
          flash[:notice] = 'Não foi possível excluir a categoria pois ela possui outras categorias relacionadas.'
          format.html { redirect_to action: 'index' }
          format.json { head :no_content }
        end
      elsif Admin::Conteudo.exists?(:categoria_id => @categoria.id)
        respond_to do |format|
          flash[:notice] = 'Não foi possível excluir a categoria pois ela possui outras categorias relacionadas.'
          format.html { redirect_to action: 'index' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          flash[:notice] = 'Ocorreu um erro ao excluir a categoria. Tente novamente.'
          format.html { redirect_to action: 'index' }
          format.json { head :no_content }
        end 
      end
    end
  end
  
  private
    def sort_column  
      params[:sort] || "ordem"  
    end  
    
    def sort_direction  
      params[:direction] || "asc"  
    end  
    
    def set_categoria
      @categoria = Admin::Categoria.find(params[:id])
    end

    def categoria_params
      params.require(:admin_categoria).permit(:nome, :url, :target_url, :ordem, :status, :categoria_id, :area_id, :imagem, :imagem_url, :imagem_target_link)
    end
    
end
