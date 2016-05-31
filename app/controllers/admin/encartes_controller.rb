class Admin::EncartesController < ApplicationController
	
  before_filter :authenticate_user!
  before_action :set_encarte, only: [:show, :edit, :update, :destroy]

  def index
      if params[:search]
        @encartes = Admin::Encarte.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @encartes = Admin::Encarte.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @encarte = Admin::Encarte.new
    @encartes = Admin::Encarte.all
  end

  def edit
  end

  def create
    @encarte = Admin::Encarte.new(encarte_params)

    respond_to do |format|
        if @encarte.save

        	params[:admin_encarte][:imagem].each do |img|
        		new_img = Admin::ImagemEncarte.new
        		new_img.id_encarte = @encarte.id
        		new_img.imagem = img

        		new_img.save
        	end

          	flash[:notice] = 'Encarte criado com sucesso.'
          	format.html { redirect_to action: 'index'}
          	format.json { render action: 'index', status: :created, location: @encarte }
    	else
          	format.html { render action: 'new' }
          	format.json { render json: @encarte.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @encarte.update(encarte_params)
          
          unless params[:admin_encarte][:imagem].blank?
              @encarte.imagens.destroy_all

             params[:admin_encarte][:imagem].each do |img|
              new_img = Admin::ImagemEncarte.new
              new_img.id_encarte = @encarte.id
              new_img.imagem = img

              new_img.save
            end
          end

           flash[:notice] = 'Encarte atualizado com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @encarte.errors, status: :unprocessable_entity }
         end
       end   
  end

  def excluiImagemDestaque
    img = Admin::Encarte.find(params[:id])
    img.remove_imagem_destaque!

    respond_to do |format|
      if img.update(imagem_destaque: '')
        flash[:notice] = 'Encarte atualizado com sucesso.'
        format.html { redirect_to action: 'index'}
      end
    end
  end

  def excluiImagemEncarte
    img = Admin::ImagemEncarte.find(params[:id])
    img.remove_imagem!

    respond_to do |format|
      if img.destroy
        flash[:notice] = 'Encarte atualizado com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
  end

  def incluirImagemArea
    flash[:notice] = 'Encarte atualizado com sucesso.'
    redirect_to action: 'edit'
  end

  def destroy
    @encarte.imagens.destroy_all
    @encarte.destroy

    respond_to do |format|
      flash[:notice] = 'Encarte excluído com sucesso.'
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
    
    def set_encarte
      @encarte = Admin::Encarte.find(params[:id])
    end

    def encarte_params
      params.require(:admin_encarte).permit(:nome, :data_inicio, :data_fim, :status, :imagem, :imagem_destaque)
    end
end
