class Admin::NovidadesController < ApplicationController
  
  before_filter :authenticate_user!
  before_action :set_novidade, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @novidades = Admin::Novidade.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @novidades = Admin::Novidade.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @novidade = Admin::Novidade.new
    @novidades = Admin::Novidade.all
  end

  def edit
  end

  def create
    @novidade = Admin::Novidade.new(novidade_params)

    respond_to do |format|
        if @novidade.save
          	flash[:notice] = 'Novidade criada com sucesso.'
          	format.html { redirect_to action: 'index'}
          	format.json { render action: 'index', status: :created, location: @novidade }
    	else
          	format.html { render action: 'new' }
          	format.json { render json: @novidade.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @novidade.update(novidade_params)
           flash[:notice] = 'Novidade atualizada com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @novidade.errors, status: :unprocessable_entity }
         end
       end   
  end

  def excluiImagemNovidade

    img = Admin::Novidade.find(params[:id])
    img.remove_imagem!
    img.imagem = ""

    respond_to do |format|
      if img.save
        flash[:notice] = 'Novidade atualizada com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
  end


def excluiImagemNovidadeListagem

    img = Admin::Novidade.find(params[:id])
    img.remove_imagem_listagem!
    img.imagem_listagem = ""

    respond_to do |format|
      if img.save
        flash[:notice] = 'Novidade atualizada com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
  end

  def destroy
    @novidade.destroy

    respond_to do |format|
      flash[:notice] = 'Novidade excluída com sucesso.'
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
    
    def set_novidade
      @novidade = Admin::Novidade.find(params[:id])
    end

    def novidade_params
      params.require(:admin_novidade).permit(:titulo, :data_inicio, :data_fim, :imagem, :preco, :unidade, :imagem_listagem, :categoria, :sumario, :conteudo)
    end
end
