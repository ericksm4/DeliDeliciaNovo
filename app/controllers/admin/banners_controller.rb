class Admin::BannersController < ApplicationController
  
   before_filter :authenticate_user!
 # load_and_authorize_resource
   before_action :set_banner, only: [:show, :edit, :update, :destroy]


  def index
      if params[:search]
        @banners = Admin::Banner.all.search(params[:search]).paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      else
        @banners = Admin::Banner.all.paginate(:per_page => 5, :page => params[:page]).order(sort_column + ' ' + sort_direction)
      end
  end

  def show
  end

  def new
    @banner = Admin::Banner.new
    @banners = Admin::Banner.all
  end

  def edit
  end

  def create
    @banner = Admin::Banner.new(banner_params)
    
    respond_to do |format|
        if @banner.save
          if params[:commit] == 'Salvar'
            atualizaOrdem(@banner.id, @banner.ordem)
            flash[:notice] = 'Banner criado com sucesso.'
            format.html { redirect_to action: 'index'}
            format.json { render action: 'index', status: :created, location: @banner }
          else
            atualizaOrdem(@banner.id, @banner.ordem)
            flash[:notice] = 'Banner criado com sucesso.'
            format.html { redirect_to edit_admin_banner_path(@banner)}
            format.json { render @banner, status: :created, location: @banner }
          end
        else
          format.html { render action: 'new' }
          format.json { render json: @banner.errors, status: :unprocessable_entity}
        end
      end
  end

  def update
       respond_to do |format|
         if @banner.update(banner_params)
            atualizaOrdem(@banner.id, @banner.ordem)
            flash[:notice] = 'Banner atualizado com sucesso.'
           format.html { redirect_to action: 'index'}
           format.json { head :no_content }
         else
           format.html { render action: 'edit' }
           format.json { render json: @banner.errors, status: :unprocessable_entity }
         end
       end   
  end

  def atualizaOrdem id_banner, ordem_banner
    update_banner = Admin::Banner.where("id <> ? AND (ordem = ?)", id_banner, ordem_banner).first
    unless update_banner.blank?
      update_banner.update(ordem: update_banner.ordem + 1)
      atualizaOrdem(update_banner.id, update_banner.ordem)
    end
  end 

  def excluiImagemBanner
    @banner = Admin::Banner.find(params[:id])
    @banner.remove_imagem!

    respond_to do |format|
      if @banner.update(imagem: '', target_link: '')
        flash[:notice] = 'Banner atualizado com sucesso.'
        format.html { redirect_to action: 'edit'}
      end
    end
  end

  def incluirImagemArea
    flash[:notice] = 'Banner atualizado com sucesso.'
    redirect_to action: 'edit'
  end

  def destroy
    @banner.destroy
    respond_to do |format|
      flash[:notice] = 'Banner excluído com sucesso.'
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
    
    def set_banner
      @banner = Admin::Banner.find(params[:id])
    end

    def banner_params
      params.require(:admin_banner).permit(:nome, :data_inicio, :data_fim, :status, :area_id, :ordem, :tempo_exibicao, :link, :target_link, :imagem, :legenda_opacidade, :legenda, :legenda_cor, :legenda_cor_fundo)
    end
    
end
