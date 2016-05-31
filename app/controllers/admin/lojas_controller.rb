class Admin::LojasController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_loja, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @lojas = Admin::Loja.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @lojas = Admin::Loja.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @loja = Admin::Loja.new
    @lojas = Admin::Loja.all
  end

  def edit
  end

  def create
    @loja = Admin::Loja.new(loja_params)
    respond_to do |format|
        if @loja.save
          	flash[:notice] = 'Loja criada com sucesso.'
          	format.html { redirect_to action: 'index'}
          	format.json { render action: 'index', status: :created, location: @loja }
    	else
          	format.html { render action: 'new' }
          	format.json { render json: @loja.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @loja.update(loja_params)
           flash[:notice] = 'Loja atualizada com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @loja.errors, status: :unprocessable_entity }
         end
       end   
  end

  def excluiImagemLoja

    @loja = Admin::Loja.find(params[:id])
    @loja.remove_imagem!

    respond_to do |format|
    	if @loja.update(imagem: '')
    		flash[:loja] = 'Loja atualizada com sucesso.'
        	format.html { redirect_to action: 'edit'}
  		end
    end
  end

  def destroy
    @loja = Admin::Loja.find(params[:id])
	@loja.destroy
    
    respond_to do |format|
      flash[:notice] = 'Loja excluída com sucesso.'
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
    
    def set_loja
      @loja = Admin::Loja.find(params[:id])
    end

    def loja_params
      params.require(:admin_loja).permit(:nome, :endereco, :cidade, :horario_funcionamento, :telefone, :url_tour, :url_maps, :imagem)
    end
end
