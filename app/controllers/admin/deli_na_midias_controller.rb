class Admin::DeliNaMidiasController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_midia, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @midias = Admin::DeliNaMidia.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @midias = Admin::DeliNaMidia.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @midia = Admin::DeliNaMidia.new
    @midias = Admin::DeliNaMidia.all
  end

  def edit
  end

  def create
    @midia = Admin::DeliNaMidia.new(midia_params)

    respond_to do |format|
        if @midia.save

        	params[:admin_deli_na_midia][:imagem].each do |img|
        		new_img = Admin::DeliNaMidiaImagem.new
        		new_img.id_midia = @midia.id
        		new_img.imagem = img

        		new_img.save
        	end

          	flash[:notice] = 'Registro criado com sucesso.'
          	format.html { redirect_to action: 'index'}
          	format.json { render action: 'index', status: :created, location: @midia }
    	else
          	format.html { render action: 'new' }
          	format.json { render json: @midia.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @midia.update(midia_params)
           @midia.imagens.destroy_all

           params[:admin_dli_na_midia][:imagem].each do |img|
            new_img = Admin::DeliNaMidiaImagem.new
            new_img.id_midia = @midia.id
            new_img.imagem = img

            new_img.save
          end

           flash[:notice] = 'Registro atualizado com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @midia.errors, status: :unprocessable_entity }
         end
       end   
  end

  def excluiImagemMidia

    img = Admin::DeliNaMidiaImagem.find(params[:id])
    img.remove_imagem!

    respond_to do |format|
      if img.destroy
        flash[:notice] = 'Registro atualizado com sucesso.'
        format.html { redirect_to action: 'index'}
      end
    end
  end

  def incluirImagemArea
    flash[:notice] = 'Registro atualizado com sucesso.'
    redirect_to action: 'edit'
  end

  def destroy
    @midia.imagens.destroy_all
    @midia.destroy

    respond_to do |format|
      flash[:notice] = 'Registro excluído com sucesso.'
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
    
    def set_midia
      @midia = Admin::DeliNaMidia.find(params[:id])
    end

    def midia_params
      params.require(:admin_deli_na_midia).permit(:titulo, :imagem, :data_inicio, :data_fim)
    end
end
