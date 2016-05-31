class Admin::LaminasController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_lamina, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @laminas = Admin::Lamina.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @laminas = Admin::Lamina.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @lamina = Admin::Lamina.new
    @laminas = Admin::Lamina.all
  end

  def edit
  end

  def create
    @lamina = Admin::Lamina.new(lamina_params)

    respond_to do |format|
        if @lamina.save
        	params[:admin_lamina][:imagem].each do |img|
        		new_img = Admin::ImagemLamina.new
        		new_img.id_lamina = @lamina.id
        		new_img.imagem = img

        		new_img.save
        	end

          	flash[:notice] = 'Lâmina criada com sucesso.'
          	format.html { redirect_to action: 'index'}
          	format.json { render action: 'index', status: :created, location: @lamina }
    	else
          	format.html { render action: 'new' }
          	format.json { render json: @lamina.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @lamina.update(lamina_params)
          unless params[:admin_lamina][:imagem].blank?
             @lamina.imagens.destroy_all

             params[:admin_lamina][:imagem].each do |img|
              new_img = Admin::ImagemLamina.new
              new_img.id_lamina = @lamina.id
              new_img.imagem = img

              new_img.save
            end
          end

           flash[:notice] = 'Lâmina atualizada com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @lamina.errors, status: :unprocessable_entity }
         end
       end   
  end

  def excluiImagemDestaque
    img = Admin::Lamina.find(params[:id])
    img.remove_imagem_destaque!

    respond_to do |format|
      if img.update(imagem_destaque: '')
        flash[:notice] = 'Lâmina atualizada com sucesso.'
        format.html { redirect_to action: 'index'}
      end
    end
  end

  def excluiImagemLamina

    img = Admin::ImagemLamina.find(params[:id])
    img.remove_imagem!

    respond_to do |format|
      if img.destroy
        flash[:notice] = 'Lâmina atualizada com sucesso.'
        format.html { redirect_to action: 'index'}
      end
    end
  end

  def incluirImagemArea
    flash[:notice] = 'Lâmina atualizada com sucesso.'
    redirect_to action: 'edit'
  end

  def destroy
    @lamina.imagens.destroy_all
    @lamina.destroy

    respond_to do |format|
      flash[:notice] = 'Lâminas excluído com sucesso.'
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
    
    def set_lamina
      @lamina = Admin::Lamina.find(params[:id])
    end

    def lamina_params
      params.require(:admin_lamina).permit(:nome, :data_inicio, :data_fim, :status, :imagem, :imagem_destaque)
    end
end
