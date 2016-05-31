module ApplicationHelper
  def sortable(column, title = nil)
	  title ||= column.titleize
	  direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
	  link_to title, :sort => column, :direction => direction
	end

  def retorna_banner nome

  	area = Admin::Area.where('nome = ?', nome).first()

  	unless area.blank? && area.imagem.blank?
  		return area.imagem.to_s
  	else
  		return ""
  	end

  end

end
