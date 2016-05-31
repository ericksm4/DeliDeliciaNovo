class EnviaEmail < ActionMailer::Base
  default from: "sac@delidelicia.com.br"

  def contato(nome, email, telefone, bairro, cidade, sugestao, newsletter)
      @nome = nome
      @email = email
      @telefone = telefone
      @bairro = bairro
      @cidade = cidade
      @sugestao = sugestao
      @newsletter = newsletter      
      
      mail(to: "erick@handcom.com.br", subject: 'Deli Delícia - Formulário de contato')
  end

  def visita(nome, email, telefone, bairro, cidade, comentarios)
      @nome = nome
      @email = email
      @telefone = telefone
      @bairro = bairro
      @cidade = cidade
      @comentarios = comentarios
      
      mail(to: "erick@handcom.com.br", subject: 'Deli Delícia - Marque sua visita')
  end

  def reserva(nome_evento)
     @nome_evento = nome_evento
     mail(to: "erick@handcom.com.br", subject: 'Deli Delícia - Reserva realizada')
  end

end
