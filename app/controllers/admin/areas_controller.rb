class Admin::AreasController < ApplicationController
  
  before_action :set_area, only: [:show, :edit, :update, :destroy, :excluiImagemArea, :incluirImagemArea]
  #load_and_authorize_resource
  
  def index
      if params[:search]
        @areas = Admin::Area.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @areas = Admin::Area.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @area = Admin::Area.new
    @areas = Admin::Area.all
  end

  def edit
    @areas = Admin::Area.all
  end

  def excluiImagemArea
    @area = Admin::Area.find(params[:id])
    @area.remove_imagem!

    respond_to do |format|
      if @area.update(imagem_url: '', imagem_target_link: '')
        flash[:notice] = 'Área atualizada com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
  end

  def incluirImagemArea
    flash[:notice] = 'Área atualizada com sucesso.'
    redirect_to action: 'edit'
  end

  def create
      @area = Admin::Area.new(area_params)
        respond_to do |format|
          if @area.save
            atualizaOrdem(@area.id, @area.ordem)
            if params[:commit] == 'Importar'
              #format.html { redirect_to action: 'areas/' + @area.id.to_s() + '/edit' }
              format.html { redirect_to :action => "edit", :id => @area.id }
              format.json { render action: 'index', location: @area }
            else
              flash[:notice] = 'Área criada com sucesso.'
              format.html { redirect_to action: 'index' }
              format.json { render action: 'index', location: @area }
            end
          else
            format.html { render action: 'new' }
             flash[:notice] = 'Erro ao criar área.'
            format.json { render json: @area.errors}
          end
        end
  end

  def areaRepetida
      if params[:id]
        @areaRepetida = Admin::Area.where('nome = ? and id <> ?', params[:nome], params[:id])
      else
        @areaRepetida = Admin::Area.where('nome = ?', params[:nome])
      end
       
      if @areaRepetida.length > 0
         resp = 1
      else
         resp = 0
      end

      render :json => resp
  end

  def atualizaOrdem id_area, ordem_area
    update_area = Admin::Area.where("id <> ? AND (ordem = ?)", id_area, ordem_area).first
    unless update_area.blank?
      update_area.update(ordem: update_area.ordem + 1)
      atualizaOrdem(update_area.id, update_area.ordem)
    end
  end 

  def update
      respond_to do |format|
         if @area.update(area_params)
          atualizaOrdem(@area.id, @area.ordem)
           flash[:notice] = 'Área atualizada com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @area.errors, status: :unprocessable_entity }
         end
      end
  end

  def destroy
    @area.destroy
    respond_to do |format|
      flash[:notice] = 'Área excluída com sucesso'
      format.html { redirect_to action: 'index'}
      format.json { head :no_content }
    end
  end

  private
    def sort_column
      params[:sort] || "ordem"
    end

    def sort_direction
      params[:direction] || "asc"
    end

    def set_area
      @area = Admin::Area.find(params[:id])
    end

    def area_params
      params.require(:admin_area).permit(:nome, :url, :ordem, :exibe_menu, :status, :imagem, :imagem_url, :imagem_target_link)
    end

    def area_imagem_update_params
      params.require(:admin_area).permit(:imagem)
    end
end
