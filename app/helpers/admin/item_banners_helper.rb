module Admin::ItemBannersHelper	
  def imagem_item_banner(item, f)
    render partial: "admin/item_banners/imagemform",
           locals: {item: item, f:f}
  end
  
  def url_item_banner(item, f)
    render partial: "admin/item_banners/urlform",
           locals: {item: item, f:f}
  end
end
