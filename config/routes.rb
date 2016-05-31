HospitalMonteSinai::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path: "",  :controllers => { :registrations => 'users/registrations', :sessions => 'users/sessions', :passwords => 'users/passwords'}, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'new' } 

  devise_scope :user do
    get '/login' => 'sessions#login'
    delete '/logout' => 'sessions#destroy'
    post '/usuarios/delete' => 'admin/usuarios#delete'
    get '/register/edit/:id' => 'admin/usuarios#edit'
    post '/usuarios/edit/' => 'admin/usuarios#edit'
  end

  #devise_for :users
  resources :home
  root 'home#index'

  get '/cadastroNewsletter' => 'application#cadastroNewsletter'

  resources :quem_somos
  resources :lamina
  resources :encarte
  resources :lojas
  resources :delivery
  resources :contato
  post 'contato/enviaContato' => 'contato#enviaContato'

  resources :faca_seu_evento
  resources :deli_sazonal
  resources :deli_na_midia
  post 'deli_na_midia/carregaImagens' => 'deli_na_midia#carregaImagens'

  resources :marque_uma_visita
  post 'marque_uma_visita/agendaVisita' => 'marque_uma_visita#marcaVisita'

  resources :novidades, :only => 'index'
  get '/novidades/:id' => 'novidades#index'

  resources :conteudos, :to => 'conteudos#index'
  resources :acontece
  post 'acontece/reserva' => 'acontece#realizaReserva'

  namespace :admin do
    resources :areas
    get 'area/:id' => 'areas#excluiImagemArea'
    get 'area/:id/incluirImagemArea' => 'areas#incluirImagemArea'
    post 'area/areaRepetida' => 'areas#areaRepetida'

    resources :home

    resources :categorias
    get '/categorias/select/:id' => 'categorias#categorias_select'
    get 'categoria/:id' => 'categorias#excluiImagemCategoria'
    get 'categoria/:id/incluirImagemCategoria' => 'categorias#incluirImagemCategoria'

    resources :conteudos
    get 'conteudo/:id' => 'conteudos#excluiImagemConteudo'
    get 'conteudo/:id/excluiImagemConteudoBanner' => 'conteudos#excluiImagemConteudoBanner'

    resources :banners
    get 'banner/:id' => 'banners#excluiImagemBanner'
    get 'banner/excluir/:id' => 'banners#destroy'

    resources :usuarios
    resources :encartes
    get 'encarte/:id' => 'encartes#excluiImagemEncarte'
    get 'encarte/excluiImagemDestaque/:id' => "encartes#excluiImagemDestaque"

    resources :laminas
    get 'lamina/:id' => 'laminas#excluiImagemLamina'
    get 'lamina/excluiImagemDestaque/:id' => "laminas#excluiImagemDestaque"

    resources :lojas
    get 'loja/:id' => 'lojas#excluiImagemLoja'

    resources :deli_sazonals, :controller => 'deli_sazonal'
    get 'deli_sazonal/:id' => 'deli_sazonal#excluiImagemSazonal'

    resources :deli_na_midias
    get 'deli_na_midia/:id' => 'deli_na_midias#excluiImagemMidia'

    resources :novidades
    get 'novidade/:id' => 'novidades#excluiImagemNovidade'
    get 'novidade/excluiImagemNovidadeListagem/:id' => "novidades#excluiImagemNovidadeListagem"

    resources :aconteces
    get 'acontece/:id' => 'aconteces#excluiImagemAcontece'

    resources :listagem_aconteces

  end

end
